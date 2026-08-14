// Configuração do Cliente Supabase para o Guia Comercial Alfenas
const SUPABASE_URL = 'https://sdwpoxtoosaseymlbgcn.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_qxJw3aamUcr9jI8m25OQrw_YdqBAn0p';

// Inicializa o cliente do Supabase globalmente
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

export { supabase };