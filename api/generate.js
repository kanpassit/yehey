export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', 'https://kanpassit.com');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  const { subjectName, aiContext, domains, weakDomains, count } = req.body || {};

  if (!subjectName || !count || count < 1 || count > 20) {
    return res.status(400).json({ error: 'Invalid request' });
  }

  const apiKey = process.env.ANTHROPIC_API_KEY;
  if (!apiKey) return res.status(500).json({ error: 'Service not configured' });

  const domainFocus = weakDomains?.length
    ? `Focus primarily on these weak areas: ${weakDomains.join(', ')}.`
    : `Cover these domains proportionally: ${(domains || []).join(', ')}.`;

  const prompt = `Generate ${count} multiple-choice practice questions for the ${subjectName} exam.
${aiContext ? `Context: ${aiContext}` : ''}
${domainFocus}

Return ONLY a valid JSON array with no extra text, markdown, or explanation. Each question must follow this exact format:
[
  {
    "q": "Full question text?",
    "opts": ["Option A text", "Option B text", "Option C text", "Option D text"],
    "correct": 0,
    "cat": "Domain Name"
  }
]

Requirements:
- "correct" is the 0-based index of the correct answer in "opts"
- "cat" must be one of the provided domain names exactly
- Questions must be exam-realistic and scenario-based where appropriate
- All four options must be plausible (avoid trivially wrong answers)
- No duplicate questions
- Do not include any text outside the JSON array`;

  try {
    const upstream = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01'
      },
      body: JSON.stringify({
        model: 'claude-sonnet-4-6',
        max_tokens: 3000,
        messages: [{ role: 'user', content: prompt }]
      })
    });

    const data = await upstream.json();
    if (!upstream.ok) {
      return res.status(upstream.status).json({ error: data.error?.message || 'Upstream API error' });
    }

    const text = data.content[0].text;
    const jsonMatch = text.match(/\[[\s\S]*\]/);
    if (!jsonMatch) return res.status(500).json({ error: 'Invalid response format from AI' });

    let questions;
    try {
      questions = JSON.parse(jsonMatch[0]);
    } catch (e) {
      return res.status(500).json({ error: 'Failed to parse AI response as JSON' });
    }

    if (!Array.isArray(questions) || questions.length === 0) {
      return res.status(500).json({ error: 'No questions generated' });
    }

    // Validate and tag each question with a unique ID
    const ts = Date.now();
    const numbered = questions
      .filter(q => q.q && Array.isArray(q.opts) && q.opts.length >= 2 && typeof q.correct === 'number')
      .map((q, i) => ({ ...q, id: `ai_${ts}_${i}` }));

    if (numbered.length === 0) {
      return res.status(500).json({ error: 'Questions failed validation' });
    }

    return res.status(200).json({ questions: numbered });
  } catch (err) {
    return res.status(500).json({ error: 'Server error' });
  }
}
