-- =====================================================================
-- Lojas cadastradas pelo próprio guia
--
-- Rode no SQL Editor, depois dos anteriores, no projeto
-- guia-comercio-alfenas.
--
-- POR QUÊ
--
-- O guia vai nascer com as lojas mais bem avaliadas de cada categoria
-- já publicadas, cadastradas pelo administrador a partir do que está
-- público no Google. Até aqui isso era impossível: todo anúncio
-- precisava de uma conta de dono, e cada conta só pode ter uma loja.
-- Criar uma conta falsa por loja encheria o painel de e-mails
-- inventados e travaria o dono de verdade quando ele chegasse.
--
-- Então o anúncio passa a poder existir sem dono. Fica com
-- user_id nulo, e o administrador cuida dele. Quando o comerciante
-- aparecer, o anúncio é passado para a conta dele (ver o fim do
-- arquivo).
--
-- O QUE NÃO MUDA: o anunciante continua tendo uma loja só, e continua
-- mexendo só na dele. O "unique" de user_id segue de pé — no Postgres
-- nulos não brigam entre si num índice único, então cem lojas sem dono
-- convivem, e duas lojas do mesmo dono continuam sendo recusadas.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. O DONO DEIXA DE SER OBRIGATÓRIO
-- ---------------------------------------------------------------------
alter table public.anuncios alter column user_id drop not null;


-- ---------------------------------------------------------------------
-- 2. O ADMINISTRADOR CRIA E APAGA QUALQUER ANÚNCIO
--
-- Editar ele já podia (004). Criar e apagar, não: a regra de criar
-- exigia user_id = auth.uid(), e a de apagar, ser o dono.
-- ---------------------------------------------------------------------
drop policy if exists "admin cria anuncio" on public.anuncios;
create policy "admin cria anuncio"
    on public.anuncios for insert
    to authenticated
    with check (public.eh_admin());

drop policy if exists "admin apaga qualquer anuncio" on public.anuncios;
create policy "admin apaga qualquer anuncio"
    on public.anuncios for delete
    to authenticated
    using (public.eh_admin());


-- ---------------------------------------------------------------------
-- 3. O PAINEL PASSA A MOSTRAR AS LOJAS SEM DONO
--
-- A lista do painel parte das pessoas cadastradas e junta a loja de
-- cada uma. Uma loja sem dono não tem pessoa, então nunca apareceria.
-- Ela entra agora numa segunda parte da lista, com:
--
--   nome_completo = 'Cadastrada pelo guia', para a coluna do
--   responsável dizer o que aconteceu em vez de ficar em branco;
--
--   telefone = o WhatsApp da loja (ou o telefone, se não houver), para
--   o botão "Falar" do painel abrir a conversa com o comércio. É
--   justamente a conversa que se quer ter: "sua loja já está no guia,
--   quer assumir o anúncio?".
-- ---------------------------------------------------------------------
create or replace function public.admin_listar_anunciantes()
returns table (
    perfil_id uuid,
    nome_completo text,
    documento text,
    tipo_documento text,
    email text,
    telefone text,
    cep text,
    logradouro text,
    numero text,
    complemento text,
    bairro text,
    cidade_responsavel text,
    uf text,
    cadastrado_em timestamptz,

    anuncio_id uuid,
    titulo text,
    cidade text,
    categoria text,
    plano text,
    destaque boolean,
    ativo boolean,
    visualizacoes integer,
    cliques_whatsapp integer,
    anuncio_criado_em timestamptz
)
language plpgsql
stable
security definer
set search_path = public
as $funcao$
begin
    if not public.eh_admin() then
        raise exception 'Acesso restrito ao administrador do guia.'
            using errcode = '42501';
    end if;

    return query
            select
                p.id,
                p.nome_completo,
                p.documento,
                p.tipo_documento,
                u.email::text,
                p.telefone,
                p.cep,
                p.logradouro,
                p.numero,
                p.complemento,
                p.bairro,
                p.cidade,
                p.uf::text,
                p.criado_em,

                a.id,
                a.titulo,
                a.cidade,
                a.categoria,
                a.plano,
                a.destaque,
                a.ativo,
                a.visualizacoes,
                a.cliques_whatsapp,
                a.criado_em
            from public.perfis p
            join auth.users u on u.id = p.id
            left join public.anuncios a on a.user_id = p.id

            union all

            select
                null::uuid,
                'Cadastrada pelo guia'::text,
                null::text,
                null::text,
                null::text,
                coalesce(nullif(a.whatsapp, ''), a.telefone),
                a.cep,
                a.logradouro,
                a.numero,
                a.complemento,
                a.bairro,
                a.cidade,
                null::text,
                a.criado_em,

                a.id,
                a.titulo,
                a.cidade,
                a.categoria,
                a.plano,
                a.destaque,
                a.ativo,
                a.visualizacoes,
                a.cliques_whatsapp,
                a.criado_em
            from public.anuncios a
            where a.user_id is null

            -- Por posição: as duas partes repetem nomes (id, cidade,
            -- criado_em), e o número evita a ambiguidade.
            -- 17 = cidade da loja, 20 = destaque, 24 = criado_em da loja.
            order by 17 nulls last, 20 desc nulls last, 24 nulls last;
end;
$funcao$;

grant execute on function public.admin_listar_anunciantes() to authenticated;


-- ---------------------------------------------------------------------
-- 4. QUANDO O COMERCIANTE APARECER
--
-- Ele cria a conta normalmente em auth/cadastro.html, SEM cadastrar
-- loja. Depois, troque o e-mail e o nome da loja abaixo e rode:
--
-- update public.anuncios
--    set user_id = (select id from auth.users where email = 'email@do.dono')
--  where user_id is null
--    and titulo = 'Nome exato da loja';
--
-- Se a pessoa já tiver criado uma loja por conta própria, o "unique"
-- recusa — apague a duplicada antes.
-- ---------------------------------------------------------------------
