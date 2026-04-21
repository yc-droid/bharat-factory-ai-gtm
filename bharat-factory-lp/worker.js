export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    if (url.pathname === '/api/lead' && request.method === 'POST') {
      try {
        const lead = await request.json();
        lead.ts = new Date().toISOString();
        lead.ip = request.headers.get('cf-connecting-ip') || '';
        lead.ua = request.headers.get('user-agent') || '';
        console.log('LEAD:', JSON.stringify(lead));
        // TODO: forward to Slack webhook, Google Sheet, or Build.ai CRM
        return new Response(JSON.stringify({ok: true}), {
          headers: {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'},
        });
      } catch (e) {
        return new Response(JSON.stringify({ok: false, err: e.message}), {status: 400});
      }
    }
    return env.ASSETS.fetch(request);
  }
};
