/* =====================================================================
   As regras comerciais do guia, num lugar só.

   Até 31/10/2026 o cadastro é grátis. A partir de 01/11/2026 quem quer
   anunciar escolhe e paga um plano.

   Essa data decide duas coisas em telas diferentes: se a faixa laranja
   da página inicial aparece, e quantas fotos o anunciante pode subir.
   Se cada tela guardasse a própria cópia da data, bastaria mudar de
   ideia uma vez para o site ficar dizendo duas coisas ao mesmo tempo —
   faixa no ar prometendo grátis, formulário cobrando plano.

   Mudou aqui, mudou no site inteiro.
   ===================================================================== */
window.REGRAS = {

    // Último instante da promoção. Depois disto a faixa some e o
    // pagamento entra no caminho do cadastro.
    gratisAte: new Date('2026-10-31T23:59:59'),

    promocaoValendo() {
        return new Date() <= this.gratisAte;
    },

    // Durante a promoção: 1 logomarca + 6 fotos = 7 imagens por loja.
    // A logo é contada à parte porque tem lugar próprio no formulário.
    fotosNaPromocao: 6,

    // Depois da promoção, quem manda é o plano contratado.
    fotosPorPlano: {
        trimestral: 5,
        semestral: 10,
        anual: 15
    },

    // Quantos anúncios cabem em "Anúncios em destaque", na página
    // inicial. São duas fileiras de quatro.
    //
    // Enquanto a promoção vale, todo mundo passa por ali, na ordem em
    // que se cadastrou: quem chegou primeiro aparece primeiro. É o que
    // faz o guia parecer vivo enquanto ainda tem poucas lojas, e é
    // justo com quem apostou no site antes de todo mundo.
    destaquesNaHome: 8,

    /**
     * Quantas fotos esta loja pode ter (fora a logomarca).
     *
     * Enquanto a promoção vale, o limite é igual para todo mundo — não
     * existe plano escolhido para consultar.
     */
    limiteDeFotos(plano) {
        if (this.promocaoValendo()) {
            return this.fotosNaPromocao;
        }

        // Loja cadastrada na promoção, sem plano, depois de 01/11/2026.
        // Fica com as 6 que já tinha direito: rebaixar para 5 apagaria
        // uma foto que a pessoa já havia publicado.
        //
        // PENDENTE: o Igor ainda vai decidir o que acontece com os
        // anunciantes gratuitos quando a cobrança começar. Até lá, o
        // combinado é não tirar nada de ninguém.
        return this.fotosPorPlano[plano] ?? this.fotosNaPromocao;
    }
};
