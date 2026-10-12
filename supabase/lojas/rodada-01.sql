-- =====================================================================
-- Lojas cadastradas pelo guia — RODADA 1
-- Academias e Esportes · Advocacia e Contabilidade · Agropecuária
--
-- Rode no SQL Editor DEPOIS da migração 013 (lojas sem dono).
-- Pode rodar mais de uma vez: loja com o mesmo nome não entra de novo.
--
-- Critério: as mais bem avaliadas no Google Maps em Alfenas, pesando a
-- nota pela quantidade de avaliações. Dados e fotos vêm do perfil do
-- Google de cada loja; só fotos publicadas pelo próprio comércio.
-- Levantamento feito em 12/10/2026.
-- =====================================================================

with novas (titulo, categoria, descricao, cep, logradouro, numero, complemento, bairro,
            telefone, whatsapp, instagram, site, horarios, imagem_url, fotos) as (
values

-- ---------------------------------------------------------------------
-- ACADEMIAS E ESPORTES
-- ---------------------------------------------------------------------

-- Google: 5,0 (61 avaliações)
('RAYFIT GYM', 'Academias e Esportes',
 'Academia no Centro de Alfenas, com musculação e espaço amplo. Aberta cedo: de segunda a quinta, das 5h às 22h.',
 '37130129', 'Av. Lincoln Westin da Silveira', '1737', 'Lj 3', 'Centro',
 '', '35999950506', '', 'https://rayfitgym.com.br/',
 '{"seg":{"aberto":true,"abre":"05:00","fecha":"22:00"},"ter":{"aberto":true,"abre":"05:00","fecha":"22:00"},"qua":{"aberto":true,"abre":"05:00","fecha":"22:00"},"qui":{"aberto":true,"abre":"05:00","fecha":"22:00"},"sex":{"aberto":true,"abre":"05:00","fecha":"21:00"},"sab":{"aberto":true,"abre":"08:00","fecha":"12:00"},"dom":{"aberto":false}}',
 'https://comercioalfenas.com.br/assets/img/lojas/rayfit-gym/3.jpg',
 array['https://comercioalfenas.com.br/assets/img/lojas/rayfit-gym/2.jpg',
       'https://comercioalfenas.com.br/assets/img/lojas/rayfit-gym/5.jpg',
       'https://comercioalfenas.com.br/assets/img/lojas/rayfit-gym/1.jpg',
       'https://comercioalfenas.com.br/assets/img/lojas/rayfit-gym/3.jpg',
       'https://comercioalfenas.com.br/assets/img/lojas/rayfit-gym/4.jpg']),

-- Google: 4,8 (104 avaliações)
('EXTREME GYM', 'Academias e Esportes',
 'Academia no Centro de Alfenas. "Transformamos sedentários em guerreiros." Aberta todos os dias, inclusive domingo de manhã.',
 '37130000', 'Av. José Paulino da Costa', '81', null, 'Centro',
 '', '35997606940', '@extremegymalfenas', '',
 '{"seg":{"aberto":true,"abre":"05:30","fecha":"22:00"},"ter":{"aberto":true,"abre":"05:30","fecha":"22:00"},"qua":{"aberto":true,"abre":"05:30","fecha":"22:00"},"qui":{"aberto":true,"abre":"05:30","fecha":"22:00"},"sex":{"aberto":true,"abre":"05:30","fecha":"21:00"},"sab":{"aberto":true,"abre":"08:00","fecha":"13:00"},"dom":{"aberto":true,"abre":"09:00","fecha":"12:00"}}',
 'https://comercioalfenas.com.br/assets/img/lojas/extreme-gym/logo.png',
 array['https://comercioalfenas.com.br/assets/img/lojas/extreme-gym/1.jpg',
       'https://comercioalfenas.com.br/assets/img/lojas/extreme-gym/2.jpg']),

-- ---------------------------------------------------------------------
-- ADVOCACIA E CONTABILIDADE (um escritório de cada)
-- ---------------------------------------------------------------------

-- Google: 5,0 (106 avaliações). O Google não informa horário.
('Taíni Silva Advocacia', 'Advocacia e Contabilidade',
 'Escritório de advocacia no Centro de Alfenas, com atendimento em Direito de Família e outras áreas.',
 '37130179', 'Rua Coronel Laurindo Ribeiro', '173', 'Sala 5', 'Centro',
 '', '35998779909', '', 'https://tainisilvaadvocacia.com.br/',
 '{}',
 'https://comercioalfenas.com.br/assets/img/lojas/taini-silva-advocacia/1.jpg',
 array['https://comercioalfenas.com.br/assets/img/lojas/taini-silva-advocacia/1.jpg']),

-- Google: 5,0 (113 avaliações)
('Contabilidade Assessorando', 'Advocacia e Contabilidade',
 'Escritório de contabilidade de Leandro Almeida, no bairro Santa Rita. Atende de segunda a sexta.',
 '37132000', 'R. João de Camargo', '231', null, 'Santa Rita',
 '', '35997251896', '', '',
 '{"seg":{"aberto":true,"abre":"07:00","fecha":"17:30"},"ter":{"aberto":true,"abre":"07:00","fecha":"17:30"},"qua":{"aberto":true,"abre":"07:00","fecha":"17:30"},"qui":{"aberto":true,"abre":"07:00","fecha":"17:30"},"sex":{"aberto":true,"abre":"07:00","fecha":"17:00"},"sab":{"aberto":false},"dom":{"aberto":false}}',
 'https://comercioalfenas.com.br/assets/img/lojas/contabilidade-assessorando/2.jpg',
 array['https://comercioalfenas.com.br/assets/img/lojas/contabilidade-assessorando/2.jpg',
       'https://comercioalfenas.com.br/assets/img/lojas/contabilidade-assessorando/1.jpg',
       'https://comercioalfenas.com.br/assets/img/lojas/contabilidade-assessorando/3.jpg',
       'https://comercioalfenas.com.br/assets/img/lojas/contabilidade-assessorando/4.jpg',
       'https://comercioalfenas.com.br/assets/img/lojas/contabilidade-assessorando/5.jpg']),

-- ---------------------------------------------------------------------
-- AGROPECUÁRIA
-- Sem fotos: no Google, nenhuma das duas tem foto publicada pela
-- própria loja. Fica a imagem padrão do guia até o dono mandar.
-- ---------------------------------------------------------------------

-- Google: 4,7 (85 avaliações). O Google não informa horário.
('Case IH - Racine Tratores', 'Agropecuária',
 'Concessionária Case IH em Alfenas: tratores, máquinas e implementos agrícolas, peças e assistência.',
 '37132204', 'Av. José Paulino da Costa', '995', null, 'Jardim Aeroporto III',
 '(35) 3291-2010', '', '', 'http://www.caseih.com/latam/pt-br',
 '{}',
 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=600&auto=format&fit=crop',
 array[]::text[]),

-- Google: 4,7 (70 avaliações)
('Rede do Campo - Agrotécnica', 'Agropecuária',
 'Agrotécnica no Centro de Alfenas: produtos para lavoura, criação e o produtor rural.',
 '37130000', 'Av. Lincoln Westin da Silveira', '1971', null, 'Centro',
 '(35) 3292-5856', '', '', 'http://rededocampo.com.br/',
 '{"seg":{"aberto":true,"abre":"07:00","fecha":"18:00"},"ter":{"aberto":true,"abre":"07:00","fecha":"18:00"},"qua":{"aberto":true,"abre":"07:00","fecha":"18:00"},"qui":{"aberto":true,"abre":"07:00","fecha":"18:00"},"sex":{"aberto":true,"abre":"07:00","fecha":"18:00"},"sab":{"aberto":true,"abre":"07:00","fecha":"12:00"},"dom":{"aberto":false}}',
 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=600&auto=format&fit=crop',
 array[]::text[])
)
insert into public.anuncios
    (user_id, titulo, categoria, descricao, cidade, cep, logradouro, numero, complemento, bairro,
     endereco, telefone, whatsapp, instagram, site, horarios, imagem_url, fotos, plano, status)
select
    null, n.titulo, n.categoria, n.descricao, 'alfenas', n.cep, n.logradouro, n.numero, n.complemento, n.bairro,
    concat_ws(' - ', n.logradouro || ', ' || n.numero, n.complemento, n.bairro),
    n.telefone, n.whatsapp, n.instagram, n.site, n.horarios::jsonb, n.imagem_url, n.fotos,
    null, 'ABERTO AGORA'
from novas n
where not exists (
    select 1 from public.anuncios a where lower(a.titulo) = lower(n.titulo)
);

-- Conferência: devem aparecer as 6 lojas desta rodada.
select titulo, categoria, whatsapp, telefone, array_length(fotos, 1) as fotos
  from public.anuncios
 where user_id is null
 order by categoria, titulo;
