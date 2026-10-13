-- =====================================================================
-- Rodada 1 — correção
--
-- Regra do guia (12/10/2026): só fica no ar comércio com FOTOS REAIS do
-- próprio estabelecimento e informações COMPLETAS (endereço, telefone e
-- horário), tudo vindo do próprio comércio. Nada genérico, nada
-- inventado.
--
-- Saem três lojas que não cumprem a regra:
--   Case IH - Racine Tratores ... sem fotos próprias no Google e sem horário
--   Rede do Campo - Agrotécnica . sem fotos próprias no Google
--   Taíni Silva Advocacia ....... sem horário; a única "foto" era um print
--
-- E as descrições das que ficam passam a usar só o que a própria empresa
-- publica.
-- =====================================================================

delete from public.anuncios
 where user_id is null
   and titulo in ('Case IH - Racine Tratores',
                  'Rede do Campo - Agrotécnica',
                  'Taíni Silva Advocacia');

-- Texto do site oficial (rayfitgym.com.br).
update public.anuncios
   set descricao = 'Academia de musculação no Centro de Alfenas MG, com equipe profissional. Treino Risco Zero: acolhimento, segurança e evolução em cada fase da vida.'
 where user_id is null and titulo = 'RAYFIT GYM';

-- Bio do Instagram oficial (@extremegymalfenas).
update public.anuncios
   set descricao = 'Transformamos sedentários em guerreiros.'
 where user_id is null and titulo = 'EXTREME GYM';

-- Sem texto próprio publicado: fica só o tipo de negócio do perfil do Google.
update public.anuncios
   set descricao = 'Escritório de contabilidade.'
 where user_id is null and titulo = 'Contabilidade Assessorando';

select titulo, categoria, descricao
  from public.anuncios
 where user_id is null
 order by categoria, titulo;
