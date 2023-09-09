-- Database: projeto

--Selects úteis
SELECT * FROM public.requisicao WHERE usuario_id = 3;
SELECT * FROM public.atividade;
SELECT * FROM public.certificado;

--RF 013 - Cadastrar Requisição
INSERT INTO public.requisicao(
    id, arquivada, criacao, data_de_submissao, id_requisicao, observacao, requisicao_arquivo_assinada, status_requisicao, token, curso_id, usuario_id)
VALUES (1301, false, '2023-12-21', '2023-12-25', 1301, 'Observação teste', pg_read_binary_file('C:\Users\Jonas\Desktop\projeto bd\sample.pdf'), 'TRANSITO', 'CEwO^8Pjxk', 12, 3);


--RF 014 - Consultar lista de requisições
-- usuario_id pode ser alterado para o id do usuário que deseja consultar as requisições
SELECT * FROM public.requisicao WHERE usuario_id = 3;

--RF 015 - Filtrar Requisições
-- por status
SELECT * FROM public.requisicao WHERE usuario_id = 3 AND status_requisicao = 'ACEITO';
--por data
SELECT * FROM public.requisicao WHERE usuario_id = 3 AND data_de_submissao = '2023-12-25';
--por observacao
SELECT * FROM public.requisicao WHERE usuario_id = 3 AND observacao = 'Observação teste';
--por curso
SELECT * FROM public.requisicao WHERE usuario_id = 3 AND curso_id = 12;

--RF 017 - Visualizar indicadores sobre as requisições enviadas
SELECT 
    r.status_requisicao,
    COUNT(*) AS quantidade,
    SUM(CASE WHEN a.eixo = 'ENSINO' THEN a.ch_por_certificado ELSE 0 END) AS horas_ensino,
    SUM(CASE WHEN a.eixo = 'PESQUISA' THEN a.ch_por_certificado ELSE 0 END) AS horas_pesquisa,
    SUM(CASE WHEN a.eixo = 'EXTENSAO' THEN a.ch_por_certificado ELSE 0 END) AS horas_extensao,
    SUM(CASE WHEN a.eixo = 'GESTAO' THEN a.ch_por_certificado ELSE 0 END) AS horas_gestao
FROM public.requisicao AS r
JOIN public.certificado AS c ON r.id = c.requisicao_id
JOIN public.atividade AS a ON c.atividade_id = a.id
WHERE r.usuario_id = 311
GROUP BY r.status_requisicao;

--RF 018 - Criar rascunhos de requisições
-- Aqui nós só colocamos o status da requisição como RASCUNHO
INSERT INTO public.requisicao(
    id, arquivada, criacao, data_de_submissao, id_requisicao, observacao, requisicao_arquivo_assinada, status_requisicao, token, curso_id, usuario_id)
VALUES (1320, false, '2023-12-21', '2023-12-25', 1320, 'Observação teste rascunho', pg_read_binary_file('C:\Users\Jonas\Desktop\projeto bd\sample.pdf'), 'RASCUNHO', 'CEwO^8Pjxk', 12, 3);

--RF 019 - Deletar rascunhos de requisições

-- Adicionar ON DELETE CASCADE na CONSTRAINT
ALTER TABLE public.certificado DROP CONSTRAINT fk4let25y9w1sqkslmiqk40njxi;

ALTER TABLE public.certificado
  ADD CONSTRAINT fk4let25y9w1sqkslmiqk40njxi
  FOREIGN KEY (requisicao_id)
  REFERENCES public.requisicao(id) 
  ON DELETE CASCADE;

-- Realizar a querry
SELECT * FROM public.requisicao WHERE status_requisicao = 'ACEITO';
DELETE FROM public.requisicao
WHERE status_requisicao = 'RASCUNHO' AND usuario_id = 3 AND id = 853;
