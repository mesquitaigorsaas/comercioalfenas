-- =====================================================================
-- Revisão das lojas cadastradas pelo guia — 13/10/2026
--
-- Os horários foram coletados em 12/10, feriado de Nossa Senhora
-- Aparecida. Nesse dia o Google mostrava a segunda-feira com o horário
-- do feriado. Conferido de novo em dia normal, três lojas abrem às
-- segundas e estavam marcadas como fechadas.
--
-- E duas lojas tinham a mesma foto de fachada repetida na galeria.
-- =====================================================================

update public.anuncios
   set horarios = jsonb_set(horarios, '{seg}', '{"aberto":true,"abre":"09:00","fecha":"18:00"}')
 where titulo = 'Betth Store Alfenas';

update public.anuncios
   set horarios = jsonb_set(horarios, '{seg}', '{"aberto":true,"abre":"07:30","fecha":"18:00"}')
 where titulo = 'Dnetto Assistência Técnica';

update public.anuncios
   set horarios = jsonb_set(horarios, '{seg}', '{"aberto":true,"abre":"09:00","fecha":"17:30"}')
 where titulo = 'Nill Cell';

-- Fotos repetidas (mesma fachada duas vezes).
update public.anuncios
   set fotos = array_remove(fotos, 'https://comercioalfenas.com.br/assets/img/lojas/fast-escova-alfenas/4.jpg')
 where titulo = 'Fast Escova Alfenas';

update public.anuncios
   set fotos = array_remove(fotos, 'https://comercioalfenas.com.br/assets/img/lojas/construai-construcar/2.jpg')
 where titulo = 'Construai - Construcar';

select titulo, horarios -> 'seg' as segunda, array_length(fotos, 1) as fotos
  from public.anuncios
 where titulo in ('Betth Store Alfenas', 'Dnetto Assistência Técnica', 'Nill Cell',
                  'Fast Escova Alfenas', 'Construai - Construcar')
 order by titulo;
