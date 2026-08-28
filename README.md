# Guia Comercial Alfenas e Região

Guia de comércios e prestadores de serviço de Alfenas e das cidades
vizinhas. Quem procura acha pelo bairro e pela categoria; quem tem
loja cadastra a dela e aparece.

No ar em **https://mesquitaigorsaas.github.io/comercioalfenas/**

---

## Como funciona

Site estático — HTML, CSS e JavaScript, sem framework e sem build. É
só abrir os arquivos. O GitHub Pages publica sozinho a cada `push` na
branch `main`.

Os dados ficam no **Supabase**: banco, contas de acesso e as imagens
dos anúncios.

### Rodando na sua máquina

Não basta abrir o arquivo com duplo clique: o navegador bloqueia
parte do JavaScript em páginas abertas direto do disco. Suba um
servidor local na pasta do projeto:

```bash
npx serve .
```

E abra o endereço que ele mostrar.

---

## Onde fica cada coisa

| Pasta / arquivo | O que é |
|---|---|
| `index.html` | Página inicial: busca e a vitrine de destaques |
| `planos.html` | Preços dos planos |
| `sobrenos.html`, `fale-conosco.html` | Páginas institucionais |
| `anuncio-detalhes.html` | A página de uma loja |
| `auth/` | Criar conta, entrar e recuperar senha |
| `dashboard/` | Painel do anunciante e o formulário do anúncio |
| `assets/js/supabase-config.js` | Endereço e chave pública do banco |
| `assets/js/regras.js` | Datas e limites da promoção |
| `assets/js/menu-promocao.js` | Para onde aponta o botão de cadastrar |
| `supabase/` | Os SQLs que montam o banco |

### Os dois arquivos de configuração

Vale conhecer, porque quase toda mudança de regra passa por eles.

**`supabase-config.js`** guarda o endereço do projeto no Supabase e a
chave pública. Antes, esses dois valores estavam copiados dentro de
cada uma das sete páginas — quando o projeto do banco mudou de
endereço, o site inteiro parou e o conserto seria trocar a mesma coisa
em sete arquivos sem esquecer nenhum.

**`regras.js`** guarda a data do fim da promoção e os limites de foto.
A mesma data decide se as faixas laranja aparecem, quantas fotos o
anunciante pode subir e para onde vai o botão de cadastrar. Separadas,
essas telas podiam passar a discordar entre si — faixa prometendo
grátis enquanto o formulário já cobrasse plano.

---

## Promoção de lançamento

Até **31/10/2026** o cadastro é gratuito:

- 1 logomarca + 6 fotos por loja
- os 8 primeiros anúncios de cada cidade aparecem na vitrine da página
  inicial, por ordem de cadastro
- os botões de cadastrar pulam a página de planos e vão direto ao
  cadastro

A partir de **01/11/2026** tudo isso se desliga sozinho: as faixas
somem, os botões voltam a passar pelos planos e o limite de fotos
passa a depender do plano contratado (5, 10 ou 15). Nada precisa ser
editado no dia — basta a data virar.

**Ainda não existe:** a cobrança. O caminho cadastro → pagamento →
anúncio precisa ser construído antes de 01/11.

---

## Banco de dados

Os arquivos em `supabase/` devem ser rodados no SQL Editor do
Supabase, **nesta ordem**, num projeto novo:

1. `schema.sql` — tabela `anuncios`, segurança e o depósito de imagens
2. `perfis.sql` — dados do responsável, com CPF/CNPJ conferido
3. `003-facebook.sql` — coluna do Facebook

### Como a segurança funciona

Todo acesso passa por *Row Level Security*: sem regra escrita, ninguém
lê nem escreve nada. O que vale é:

- **Anúncios** são públicos para leitura — é um guia, existem para
  serem vistos. Só o dono cria, edita e apaga o dele.
- **Perfis** (nome, CPF/CNPJ, endereço) só são visíveis para o próprio
  dono. Nem visitantes nem outros anunciantes alcançam.
- **Visualizações e cliques no WhatsApp** são somados por funções do
  banco, não por escrita direta. Liberar alteração da tabela para o
  visitante anônimo — que é quem dispara essa contagem — deixaria
  qualquer um reescrever o anúncio de qualquer loja.
- **CPF/CNPJ** é conferido pelos dígitos verificadores duas vezes: na
  tela, para avisar na hora, e no banco, que é o que garante. E é
  único, para uma pessoa não abrir várias contas e ocupar o guia
  sozinha enquanto o cadastro é grátis.

### A chave que aparece no código

A chave em `supabase-config.js` é pública de propósito: ela viaja até
o navegador de quem visita, e qualquer um pode lê-la. Não é descuido —
é assim que o Supabase funciona. Quem decide o que cada pessoa pode
ver e mexer são as regras acima, do lado do banco.

**A senha do banco não está no repositório e não deve entrar nele.**
Ela fica no arquivo `Dados do Site.txt`, que o `.gitignore` mantém de
fora.
