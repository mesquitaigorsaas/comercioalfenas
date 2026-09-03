/* =====================================================================
   O cabeçalho sabe quem está logado.

   As páginas públicas mostravam sempre a mesma coisa: uma chave para
   entrar e o botão de cadastrar anúncio. Quem já tinha entrado via a
   chave de "Entrar" mesmo estando dentro, e não tinha por onde sair —
   precisava ir até o painel para achar o "Sair".

   Agora, com sessão aberta, a chave vira o atalho para o painel e um
   "Sair" aparece ao lado. Sem sessão, nada muda.

   O estilo vem junto, injetado por este arquivo. O cabeçalho está
   escrito à mão em cada uma das seis páginas, com o CSS repetido
   dentro de cada uma; acrescentar um botão pelo caminho normal seria
   editar seis blocos iguais e manter os seis em dia daqui para
   frente.

   Precisa de supabase-config.js e da biblioteca do Supabase antes.
   ===================================================================== */
(function () {
    'use strict';

    // Sem a biblioteca ou sem a configuração não há como perguntar se
    // existe sessão. A página continua funcionando como sempre.
    if (!window.supabase || !window.CONFIG_SUPABASE) {
        return;
    }

    const cliente = window.supabase.createClient(
        window.CONFIG_SUPABASE.url,
        window.CONFIG_SUPABASE.chavePublica
    );

    function injetarEstilo() {
        if (document.getElementById('estilo-sessao-topo')) return;

        const estilo = document.createElement('style');
        estilo.id = 'estilo-sessao-topo';
        estilo.textContent = `
            .btn-sair-topo {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                height: 38px;
                padding: 0 14px;
                border: 1px solid #e2e8f0;
                border-radius: 6px;
                background: #ffffff;
                color: #475569;
                font-family: inherit;
                font-size: 0.78rem;
                font-weight: 700;
                letter-spacing: 0.4px;
                text-transform: uppercase;
                text-decoration: none;
                cursor: pointer;
                transition: all 0.2s;
                white-space: nowrap;
            }

            .btn-sair-topo:hover {
                border-color: #e11d48;
                color: #e11d48;
                background: #fff1f2;
            }

            /* Em tela estreita o "+ CADASTRAR ANÚNCIO" já some. O Sair
               fica, porque é a única saída da conta nessa largura. */
            @media (max-width: 600px) {
                .btn-sair-topo span { display: none; }
                .btn-sair-topo { padding: 0 12px; }
            }
        `;
        document.head.appendChild(estilo);
    }

    async function sair(evento) {
        evento.preventDefault();
        await cliente.auth.signOut();

        // Recarrega em vez de só trocar os botões: se a pessoa estava
        // numa página que depende da sessão, ela precisa ser relida
        // como visitante.
        window.location.reload();
    }

    async function ajustarCabecalho() {
        const { data: { session } } = await cliente.auth.getSession();
        if (!session) return;

        const acoes = document.querySelector('.header-actions');
        const chave = document.querySelector('.btn-icon-login');
        if (!acoes || document.getElementById('btnSairTopo')) return;

        injetarEstilo();

        // A chave dizia "Entrar" para quem já entrou. Vira o caminho
        // para o painel, que é o que essa pessoa quer ao clicar ali.
        if (chave) {
            chave.setAttribute('href', 'dashboard/dashboard.html');
            chave.setAttribute('title', 'Meu painel');
            chave.innerHTML = '<i class="fa-solid fa-gauge"></i>';
        }

        const botao = document.createElement('a');
        botao.id = 'btnSairTopo';
        botao.className = 'btn-sair-topo';
        botao.href = '#';
        botao.innerHTML = '<i class="fa-solid fa-right-from-bracket"></i> <span>Sair</span>';
        botao.addEventListener('click', sair);

        // Depois da chave e antes do "+ CADASTRAR ANÚNCIO": sair é uma
        // saída, não uma ação principal, e não deve ser a primeira
        // coisa que o olho encontra no canto.
        acoes.insertBefore(botao, acoes.lastElementChild);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', ajustarCabecalho);
    } else {
        ajustarCabecalho();
    }
}());
