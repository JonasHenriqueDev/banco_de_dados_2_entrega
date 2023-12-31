PGDMP     (    $                {            acs    15.3    15.3 0    :           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ;           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            <           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            =           1262    142155    acs    DATABASE     z   CREATE DATABASE acs WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE acs;
                postgres    false                        2615    145108    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            >           0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   postgres    false    5            ?           0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                   postgres    false    5            �            1259    145118 	   atividade    TABLE     �   CREATE TABLE public.atividade (
    id bigint NOT NULL,
    ch_maxima integer NOT NULL,
    descricao character varying(255),
    eixo character varying(255),
    criterios_para_avaliacao character varying(255),
    ch_por_certificado integer
);
    DROP TABLE public.atividade;
       public         heap    postgres    false    5            �            1259    145165    atividade_seq    SEQUENCE     w   CREATE SEQUENCE public.atividade_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.atividade_seq;
       public          postgres    false    5            �            1259    145130    certificado    TABLE     �  CREATE TABLE public.certificado (
    id bigint NOT NULL,
    carga_horaria real NOT NULL,
    certificado bytea,
    data_final date,
    data_inicial date,
    observacao text,
    status_certificado character varying(255),
    titulo character varying(255),
    atividade_id bigint,
    requisicao_id bigint,
    CONSTRAINT certificado_status_certificado_check CHECK (((status_certificado)::text = ANY ((ARRAY['RASCUNHO'::character varying, 'PROBLEMA'::character varying, 'ENCAMINHADO_COORDENACAO'::character varying, 'ENCAMINHADO_COMISSAO'::character varying, 'ENCAMINHADO_ESCOLARIDADE'::character varying, 'CONCLUIDO'::character varying])::text[])))
);
    DROP TABLE public.certificado;
       public         heap    postgres    false    5            �            1259    145166    certificado_seq    SEQUENCE     y   CREATE SEQUENCE public.certificado_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.certificado_seq;
       public          postgres    false    5            �            1259    145125    curso    TABLE     �   CREATE TABLE public.curso (
    id bigint NOT NULL,
    horas_complementares integer NOT NULL,
    nome character varying(255),
    sigla character varying(255)
);
    DROP TABLE public.curso;
       public         heap    postgres    false    5            �            1259    145167 	   curso_seq    SEQUENCE     s   CREATE SEQUENCE public.curso_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.curso_seq;
       public          postgres    false    5            �            1259    145140    endereco    TABLE     #  CREATE TABLE public.endereco (
    id bigint NOT NULL,
    uf character varying(255),
    bairro character varying(255),
    cep character varying(255),
    cidade character varying(255),
    complemento character varying(255),
    numero integer NOT NULL,
    rua character varying(255)
);
    DROP TABLE public.endereco;
       public         heap    postgres    false    5            �            1259    145168    endereco_seq    SEQUENCE     v   CREATE SEQUENCE public.endereco_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.endereco_seq;
       public          postgres    false    5            �            1259    145109    flyway_schema_history    TABLE     �  CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);
 )   DROP TABLE public.flyway_schema_history;
       public         heap    postgres    false    5            �            1259    145147 
   requisicao    TABLE     q  CREATE TABLE public.requisicao (
    id bigint NOT NULL,
    arquivada boolean NOT NULL,
    criacao date,
    data_de_submissao date,
    id_requisicao character varying(255),
    observacao text,
    requisicao_arquivo_assinada bytea,
    status_requisicao character varying(255),
    token character varying(255),
    curso_id bigint,
    usuario_id bigint,
    CONSTRAINT requisicao_status_requisicao_check CHECK (((status_requisicao)::text = ANY ((ARRAY['RASCUNHO'::character varying, 'PROBLEMA'::character varying, 'TRANSITO'::character varying, 'ACEITO'::character varying, 'NEGADO'::character varying])::text[])))
);
    DROP TABLE public.requisicao;
       public         heap    postgres    false    5            �            1259    145169    requisicao_seq    SEQUENCE     x   CREATE SEQUENCE public.requisicao_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.requisicao_seq;
       public          postgres    false    5            �            1259    145155    usuario    TABLE     -  CREATE TABLE public.usuario (
    id bigint NOT NULL,
    codigo_verificacao character varying(255),
    cpf character varying(255),
    email character varying(255),
    horas_ensino real NOT NULL,
    horas_extensao real NOT NULL,
    horas_gestao real NOT NULL,
    horas_pesquisa real NOT NULL,
    is_verificado boolean NOT NULL,
    matricula character varying(255),
    nome_completo character varying(255),
    perfil character varying(255),
    periodo integer NOT NULL,
    senha character varying(255),
    telefone character varying(255),
    curso_id bigint,
    endereco_id bigint,
    CONSTRAINT usuario_perfil_check CHECK (((perfil)::text = ANY ((ARRAY['COMISSAO'::character varying, 'COORDENADOR'::character varying, 'ALUNO'::character varying, 'ADMINISTRADOR'::character varying])::text[])))
);
    DROP TABLE public.usuario;
       public         heap    postgres    false    5            �            1259    145170    usuario_seq    SEQUENCE     u   CREATE SEQUENCE public.usuario_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.usuario_seq;
       public          postgres    false    5            ,          0    145118 	   atividade 
   TABLE DATA           q   COPY public.atividade (id, ch_maxima, descricao, eixo, criterios_para_avaliacao, ch_por_certificado) FROM stdin;
    public          postgres    false    215   X?       .          0    145130    certificado 
   TABLE DATA           �   COPY public.certificado (id, carga_horaria, certificado, data_final, data_inicial, observacao, status_certificado, titulo, atividade_id, requisicao_id) FROM stdin;
    public          postgres    false    217   �F       -          0    145125    curso 
   TABLE DATA           F   COPY public.curso (id, horas_complementares, nome, sigla) FROM stdin;
    public          postgres    false    216   �F       /          0    145140    endereco 
   TABLE DATA           Y   COPY public.endereco (id, uf, bairro, cep, cidade, complemento, numero, rua) FROM stdin;
    public          postgres    false    218   /I       +          0    145109    flyway_schema_history 
   TABLE DATA           �   COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
    public          postgres    false    214   LI       0          0    145147 
   requisicao 
   TABLE DATA           �   COPY public.requisicao (id, arquivada, criacao, data_de_submissao, id_requisicao, observacao, requisicao_arquivo_assinada, status_requisicao, token, curso_id, usuario_id) FROM stdin;
    public          postgres    false    219   �I       1          0    145155    usuario 
   TABLE DATA           �   COPY public.usuario (id, codigo_verificacao, cpf, email, horas_ensino, horas_extensao, horas_gestao, horas_pesquisa, is_verificado, matricula, nome_completo, perfil, periodo, senha, telefone, curso_id, endereco_id) FROM stdin;
    public          postgres    false    220   J       @           0    0    atividade_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.atividade_seq', 1, false);
          public          postgres    false    221            A           0    0    certificado_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.certificado_seq', 1, false);
          public          postgres    false    222            B           0    0 	   curso_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.curso_seq', 1, false);
          public          postgres    false    223            C           0    0    endereco_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.endereco_seq', 1, false);
          public          postgres    false    224            D           0    0    requisicao_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.requisicao_seq', 1, false);
          public          postgres    false    225            E           0    0    usuario_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.usuario_seq', 1, false);
          public          postgres    false    226            �           2606    145124    atividade atividade_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.atividade
    ADD CONSTRAINT atividade_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.atividade DROP CONSTRAINT atividade_pkey;
       public            postgres    false    215            �           2606    145137    certificado certificado_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.certificado
    ADD CONSTRAINT certificado_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.certificado DROP CONSTRAINT certificado_pkey;
       public            postgres    false    217            �           2606    145129    curso curso_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.curso DROP CONSTRAINT curso_pkey;
       public            postgres    false    216            �           2606    145146    endereco endereco_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.endereco DROP CONSTRAINT endereco_pkey;
       public            postgres    false    218            �           2606    145116 .   flyway_schema_history flyway_schema_history_pk 
   CONSTRAINT     x   ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);
 X   ALTER TABLE ONLY public.flyway_schema_history DROP CONSTRAINT flyway_schema_history_pk;
       public            postgres    false    214            �           2606    145154    requisicao requisicao_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.requisicao
    ADD CONSTRAINT requisicao_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.requisicao DROP CONSTRAINT requisicao_pkey;
       public            postgres    false    219            �           2606    145164 '   requisicao uk_fnv531t8lswu8b7o45dt6d4v8 
   CONSTRAINT     k   ALTER TABLE ONLY public.requisicao
    ADD CONSTRAINT uk_fnv531t8lswu8b7o45dt6d4v8 UNIQUE (id_requisicao);
 Q   ALTER TABLE ONLY public.requisicao DROP CONSTRAINT uk_fnv531t8lswu8b7o45dt6d4v8;
       public            postgres    false    219            �           2606    145162    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    220            �           1259    145117    flyway_schema_history_s_idx    INDEX     `   CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);
 /   DROP INDEX public.flyway_schema_history_s_idx;
       public            postgres    false    214            �           2606    145181 &   requisicao fk3rgmc656bt0w46sa65tbadeq9    FK CONSTRAINT     �   ALTER TABLE ONLY public.requisicao
    ADD CONSTRAINT fk3rgmc656bt0w46sa65tbadeq9 FOREIGN KEY (curso_id) REFERENCES public.curso(id);
 P   ALTER TABLE ONLY public.requisicao DROP CONSTRAINT fk3rgmc656bt0w46sa65tbadeq9;
       public          postgres    false    216    219    3212            �           2606    145176 '   certificado fk4let25y9w1sqkslmiqk40njxi    FK CONSTRAINT     �   ALTER TABLE ONLY public.certificado
    ADD CONSTRAINT fk4let25y9w1sqkslmiqk40njxi FOREIGN KEY (requisicao_id) REFERENCES public.requisicao(id);
 Q   ALTER TABLE ONLY public.certificado DROP CONSTRAINT fk4let25y9w1sqkslmiqk40njxi;
       public          postgres    false    217    219    3218            �           2606    145196 #   usuario fk8fl5dxscva53gw12f19q6qxf8    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk8fl5dxscva53gw12f19q6qxf8 FOREIGN KEY (endereco_id) REFERENCES public.endereco(id);
 M   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk8fl5dxscva53gw12f19q6qxf8;
       public          postgres    false    218    220    3216            �           2606    145171 '   certificado fkatx4w949m3ibtpjxih1kwskus    FK CONSTRAINT     �   ALTER TABLE ONLY public.certificado
    ADD CONSTRAINT fkatx4w949m3ibtpjxih1kwskus FOREIGN KEY (atividade_id) REFERENCES public.atividade(id);
 Q   ALTER TABLE ONLY public.certificado DROP CONSTRAINT fkatx4w949m3ibtpjxih1kwskus;
       public          postgres    false    217    215    3210            �           2606    145186 &   requisicao fkk30a4pngkitalgorf6ntbqf3g    FK CONSTRAINT     �   ALTER TABLE ONLY public.requisicao
    ADD CONSTRAINT fkk30a4pngkitalgorf6ntbqf3g FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);
 P   ALTER TABLE ONLY public.requisicao DROP CONSTRAINT fkk30a4pngkitalgorf6ntbqf3g;
       public          postgres    false    3222    220    219            �           2606    145191 #   usuario fkoyy18bfj08k5e0rxq1qhx68s7    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fkoyy18bfj08k5e0rxq1qhx68s7 FOREIGN KEY (curso_id) REFERENCES public.curso(id);
 M   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fkoyy18bfj08k5e0rxq1qhx68s7;
       public          postgres    false    3212    220    216            ,   N  x��XMo�F=S�b��(��d'7E���v�C.+r-�Ar�]R(�kj�P$�On/�����S2�ƭS��ܝ}3���,����w����P��	��~��w�OTh��e���o�.��K)���o��"��bI(q�{-d�G�V���?�y2;�U��}-k�ogS��X��q(L&f��g������7)^�����Y�''�f!���j��B�z��U�~�c�McF`?P��e�ߥ�%6u@�ǳ��!EiZ;��D��2W�9m`b���l��������z�'��O��Ω�����t:T�r2΁]�o��i�0���fR/�_db��Ǥb���A�z�]o��)_�H��d�C�\je��X)Qı/����U�	c�\�P���8�Fi\�7- u���y/}���A��]Cu�G�Ȍ���q~�R�pY�����3��(S3��K/P�V�YȰb>aa��4龁���j�Wq]W�<c�I٧�l�5�%<�Q.�� �(�W:��9K�0�r�%0?B/(b�Л[i2��b� �B�׌g�L�bRĲ@L���:��*BcJ*�����^Ȉ�$��~o8$��KlA��eb���b��2[�!jέQ��F��[@Т'�	ޖ/}�`�wd՛���<9�x��Kւ�8�V��>�%�F�h�y 4��0Me��B���l�3����>aT�W��_�M ����3�x;H�z{]�C�o�%��YR�,͸�4�)�n��T�Ƣu5Cf�ʌ��ŧ���<�- /5i�Q`j�WY�K#�P�ld��zB����@ʌ�j$EL�f�ӵ�Q���P^8�l�|���iٰC��ԪN%^��!�Q��)�� '�Y���>��^&T�`:�&tQ��.��hHDbY!s��]~�s�D�٠[���"?+����1��)Dt��JhS��aW��Th����a�W��س���q;yH� Tt4���rG�(�+����JN_���Pn��j�R�g��G�%aH,K k��ao��]��]v�F�Or�7ڇ@u�<�å(����Z�]U�niG&�z3��L�/��bG#bל��4�H�bC�G�Vd}g1�>�QfِX�VE�+N��(�S+ͼT����,�	<B���E�ਸ਼�U��Fް�O�\k�ky�����6[��z������F����I�<��{'��s����F�&k<,�x���
�v�S�3�5�_R�Jy<F�T��.���/к'������t�_ު�*Hr�s\�LȖ��Is��I�&���
�������c*X�5�d~�Ts�S�ݸ2���aW�72H���X���'��$��M	PA�-�,}�~T�w{�=�Z.U�n�1�Ԍ�D�oI�i��t���i�+2�Acԥ&.v�H����5�V�b@�!rV|^�1�4�@Ayr�<�"�+ӺF\����b<E�Ǆ�Q�fv~������v[��p)�ĵ�۹�Ug��~���^Qd	�oW��С��#���l�����_��!��WrI^b+'-1�WY��ٕ�:Q�� Kqy6����uc�H�C�M�*o�|�/v8�J ϴյ�`֠ �3�.�4��o��* � �3�{f��@��X[r�=���c��J�d5������RL>-���ټ2@�s�%�}��2V7���/p+�1&M���I}e�8�p����\٘��-�~]��|�~�I�>^aZ���ό�͛	Ԥ�,��"�"�l��M�z�V���d�P�ott=U���<�=0B�%V��m��r2b
p���0L�1Fk�J�l����v�ѷ7봱ͯ��w&�BZ��ge�"��~�z�����      .      x������ � �      -   L  x��S�n�0<s�B_PX��8G[��eTjO��2-�H����i{(R �4�^�c]�n�H�$a�ݙِ��	I��.k��`)TkQ��,���|��#z����ꎃa����H���E�n�},Xۇ�]���n�j4�FniW.v'zc5����],�F㋵��(Zq~%�]���,8*m�f�=x��#��2�e��i�!R�yD?`9�q�̀���A8q`93�����H�� ]x�w�Q+=�]'$���.V9���$�fd%4F�U���K�,Q��K@��5�#t��kCe�偡2A"N�%4I�C8�L�0��	4)p؛��8�I�U�r����O���y����ڛOLsBK��K@��{�q����-G�)ܞO�'� �^�-�kH��jQ��Ze�}}.� �^�缶_|>�	D��3�㐣���uѕ�_�^��/Gt�:-�����|'j!�,��Ӿp�����Y.vH�j���U�� �tn��s|[�{Ǖ��tj�R��H�@�mWr}Bx�o�%%��w]�f��S�W��x#�?��/�pd�P�����������Yq�Pe�� ��Z      /      x������ � �      +   �   x����
�0F盧�Zr���������$�E
b��>���ť��������F�ÞN�������=Ɣ�S�R�B���b[Hi<���@���)o���K�-b��K"X���p�X�9!$���5����_Xy���ǌ+��}��R�G�      0      x������ � �      1      x������ � �     