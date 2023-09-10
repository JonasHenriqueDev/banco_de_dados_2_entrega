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
-- Visualizar status das requisções
SELECT status_requisicao, id FROM public.requisicao WHERE usuario_id = 1;
-- Visualizar quantidade de requisições com status 'RASCUNHO
SELECT COUNT(status_requisicao) FROM public.requisicao WHERE usuario_id = 1 AND status_requisicao = 'RASCUNHO';
-- Visualizar quantidade de horas contabilizadas por eixo
SELECT horas_ensino, horas_extensao, horas_gestao, horas_pesquisa FROM public.usuario WHERE id = 1;

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
SELECT * FROM public.requisicao WHERE status_requisicao = 'RASCUNHO';
DELETE FROM public.requisicao
WHERE status_requisicao = 'RASCUNHO' AND usuario_id = 3 AND id = 853;

--RF 020 - Alterar rascunhos de requisições
-- Aqui nós fizemos outro INSERT, pois o registro havia sido apagado


--RF 021 - Enviar solicitação à coordenação
-- Aqui alteramos o status da requisição de 'RASCUNHO' para 'TRANSITO'
SELECT * FROM public.requisicao WHERE usuario_id = 3 AND id = 1320;
UPDATE public.requisicao
SET status_requisicao = 'TRANSITO'
WHERE status_requisicao = 'RASCUNHO' AND usuario_id = 3 AND id = 1320;

--RF 022


--RF 023 - Visualizar dados do discente
-- Aqui criamos um View que contém o somatório de horas de um usuário específico
CREATE VIEW total_horas AS SELECT horas_ensino + horas_extensao + horas_gestao + horas_pesquisa FROM public.usuario WHERE id = 1;
SELECT * FROM total_horas;

--RF 024 - Visualizar fluxo de requisição
-- Aqui utilizamos SELECT para verificar o status de uma requisição específica
SELECT status_requisicao FROM public.requisicao WHERE usuario_id = 1 AND id = 861;

--RF 026 - Visualização de Perfil
-- Utilizamos o SELECT para verificar apenas o nome do usuário e o email, pois não há campo que represente uma foto de perfil
SELECT nome_completo, email FROM public.usuario WHERE id = 24;

--RF 027 - Arquivar Solicitação
-- Utilizamos o UPDATE para atualizar os registros não arquivados onde o status está como 'NEGADO'
UPDATE public.requisicao
SET arquivada = 'true'
WHERE usuario_id = 102 AND arquivada = 'false' AND status_requisicao = 'NEGADO';

--RF 028 - Deletar Solicitação
-- Criamos uma nova tabela lixeira
CREATE TABLE lixeira (
    id BIGINT PRIMARY KEY,
    arquivada BOOLEAN,
    criacao DATE,
    data_de_submissao DATE,
    id_requisicao VARCHAR(255),
    observacao TEXT,
    requisicao_arquivo_assinada BYTEA,
    status_requisicao VARCHAR(255),
    token VARCHAR(255),
    curso_id BIGINT,
    usuario_id BIGINT
);

-- Adicionamos na tabela lixeira as requisições de um usuário onde o status estava como 'NEGADO' ou 'PROBLEMA'
INSERT INTO public.lixeira SELECT * FROM public.requisicao WHERE usuario_id = 114 AND status_requisicao = 'NEGADO' OR status_requisicao = 'PROBLEMA';
-- Utilizamos o DELETE para deletar esses registros da tabela requisicao
DELETE FROM public.requisicao
WHERE usuario_id = 114 AND status_requisicao = 'NEGADO' OR status_requisicao = 'PROBLEMA';

--RF 030 - Modal de Lixeira
-- Utilizamos um SELECT para visualizar as requisições na lixeira de um usuário
SELECT * FROM public.lixeira WHERE usuario_id = 114;

