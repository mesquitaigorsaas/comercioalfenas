/* =====================================================================
   Endereço do banco de dados — um lugar só.

   Antes, cada uma das 7 páginas do site carregava sua própria cópia
   destes dois valores. Quando o projeto do Supabase mudou de endereço,
   o site inteiro parou de funcionar de uma vez, e consertar era achar
   e trocar em 7 arquivos diferentes sem esquecer nenhum.

   Agora é aqui e pronto. Trocou aqui, trocou em todo o site.

   Estes dois valores são públicos de propósito: eles viajam dentro da
   página até o navegador de quem visita, então qualquer pessoa pode
   lê-los. Não é descuido, é como o Supabase foi feito. Quem decide o
   que cada visitante pode ver e mexer são as regras de segurança (RLS)
   escritas em supabase/schema.sql, do lado do banco.

   A senha do banco NÃO está aqui e nunca deve estar. Ela mora só no
   arquivo "Dados do Site.txt", que o .gitignore mantém fora do GitHub.
   ===================================================================== */
window.CONFIG_SUPABASE = {
    url: 'https://qnnjvgjtmdolwyxrgghp.supabase.co',
    chavePublica: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFubmp2Z2p0bWRvbHd5eHJnZ2hwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODc5NDQ5NzUsImV4cCI6MjEwMzUyMDk3NX0.ZI6tPCfIVV5lge61gaJffPzpz7t6Qe5627AhNOtSVjs'
};
