PGDMP  #                    }            trabalho_pratico    17.2 (Debian 17.2-1.pgdg120+1)    17.2 (Debian 17.2-1.pgdg120+1) @    d           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            e           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            f           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            g           1262    16508    trabalho_pratico    DATABASE     {   CREATE DATABASE trabalho_pratico WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
     DROP DATABASE trabalho_pratico;
                     postgres    false            �            1255    16509    validar_venda(integer) 	   PROCEDURE     >  CREATE PROCEDURE public.validar_venda(IN id_venda integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    total_calculado DECIMAL;
    total_registrado DECIMAL;
BEGIN
    SELECT COALESCE(SUM(produto.valor * item.quantidade), 0) INTO total_calculado
    FROM item JOIN produto ON item.produto_codigo = produto.codigo
    WHERE item.venda_codigo = id_venda;

    SELECT valor_total INTO total_registrado FROM venda WHERE codigo = id_venda;

    IF total_calculado != total_registrado THEN
        RAISE EXCEPTION 'Erro: valores não batem!';
    END IF;
    
    COMMIT;
END;
$$;
 :   DROP PROCEDURE public.validar_venda(IN id_venda integer);
       public               postgres    false            �            1255    16510    verificar_estoque()    FUNCTION     �  CREATE FUNCTION public.verificar_estoque() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    estoque_atual INT;
BEGIN
    -- Buscar o estoque do produto correto
    SELECT quantidade INTO estoque_atual FROM produto WHERE codigo = NEW.produto_codigo;
    
    -- Verificar se há estoque suficiente
    IF estoque_atual < NEW.quantidade THEN
        RAISE EXCEPTION 'Estoque insuficiente!';
    END IF;
    
    RETURN NEW;
END;
$$;
 *   DROP FUNCTION public.verificar_estoque();
       public               postgres    false            �            1259    16511 
   fornecedor    TABLE     e   CREATE TABLE public.fornecedor (
    codigo integer NOT NULL,
    descricao character varying(45)
);
    DROP TABLE public.fornecedor;
       public         heap r       postgres    false            �            1259    16514    fornecedor_codigo_seq    SEQUENCE     �   CREATE SEQUENCE public.fornecedor_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.fornecedor_codigo_seq;
       public               postgres    false    217            h           0    0    fornecedor_codigo_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.fornecedor_codigo_seq OWNED BY public.fornecedor.codigo;
          public               postgres    false    218            �            1259    16515    item    TABLE     �   CREATE TABLE public.item (
    codigo integer NOT NULL,
    quantidade integer NOT NULL,
    valor_parcial numeric(9,2) NOT NULL,
    produto_codigo integer NOT NULL,
    venda_codigo integer NOT NULL
);
    DROP TABLE public.item;
       public         heap r       postgres    false            i           0    0 
   TABLE item    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.item TO vendedor;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.item TO gerente;
          public               postgres    false    219            �            1259    16518    item_codigo_seq    SEQUENCE     �   CREATE SEQUENCE public.item_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.item_codigo_seq;
       public               postgres    false    219            j           0    0    item_codigo_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.item_codigo_seq OWNED BY public.item.codigo;
          public               postgres    false    220            k           0    0    SEQUENCE item_codigo_seq    ACL     9   GRANT ALL ON SEQUENCE public.item_codigo_seq TO gerente;
          public               postgres    false    220            �            1259    16519    pessoa    TABLE     �   CREATE TABLE public.pessoa (
    codigo integer NOT NULL,
    nome character varying(45) NOT NULL,
    cpf character varying(14),
    funcao character varying(50)
);
    DROP TABLE public.pessoa;
       public         heap r       postgres    false            �            1259    16522    pessoa_codigo_seq    SEQUENCE     �   CREATE SEQUENCE public.pessoa_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.pessoa_codigo_seq;
       public               postgres    false    221            l           0    0    pessoa_codigo_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.pessoa_codigo_seq OWNED BY public.pessoa.codigo;
          public               postgres    false    222            �            1259    16523    produto    TABLE     �   CREATE TABLE public.produto (
    codigo integer NOT NULL,
    descricao character varying(50),
    valor numeric(9,2) NOT NULL,
    quantidade integer NOT NULL,
    fornecedor_codigo integer NOT NULL
);
    DROP TABLE public.produto;
       public         heap r       postgres    false            m           0    0    TABLE produto    ACL     �   GRANT SELECT ON TABLE public.produto TO vendedor;
GRANT SELECT,INSERT,DELETE,TRIGGER,UPDATE ON TABLE public.produto TO gerente;
          public               postgres    false    223            �            1259    16526    produto_codigo_seq    SEQUENCE     �   CREATE SEQUENCE public.produto_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.produto_codigo_seq;
       public               postgres    false    223            n           0    0    produto_codigo_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.produto_codigo_seq OWNED BY public.produto.codigo;
          public               postgres    false    224            o           0    0    SEQUENCE produto_codigo_seq    ACL     <   GRANT ALL ON SEQUENCE public.produto_codigo_seq TO gerente;
          public               postgres    false    224            �            1259    16527    venda    TABLE     �   CREATE TABLE public.venda (
    codigo integer NOT NULL,
    horario timestamp without time zone NOT NULL,
    valor_total numeric(9,2) NOT NULL,
    pessoa_codigo_vendedor integer NOT NULL,
    pessoa_codigo_comprador integer NOT NULL
);
    DROP TABLE public.venda;
       public         heap r       postgres    false            p           0    0    TABLE venda    ACL     ,   GRANT ALL ON TABLE public.venda TO gerente;
          public               postgres    false    225            �            1259    16530    venda_codigo_seq    SEQUENCE     �   CREATE SEQUENCE public.venda_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.venda_codigo_seq;
       public               postgres    false    225            q           0    0    venda_codigo_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.venda_codigo_seq OWNED BY public.venda.codigo;
          public               postgres    false    226            r           0    0    SEQUENCE venda_codigo_seq    ACL     :   GRANT ALL ON SEQUENCE public.venda_codigo_seq TO gerente;
          public               postgres    false    226            �            1259    16577    vendas    TABLE     _  CREATE TABLE public.vendas (
    codigo integer NOT NULL,
    data timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    produto_codigo integer,
    quantidade integer NOT NULL,
    total numeric(10,2) NOT NULL,
    CONSTRAINT vendas_quantidade_check CHECK ((quantidade > 0)),
    CONSTRAINT vendas_total_check CHECK ((total >= (0)::numeric))
);
    DROP TABLE public.vendas;
       public         heap r       postgres    false            �            1259    16576    vendas_codigo_seq    SEQUENCE     �   CREATE SEQUENCE public.vendas_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.vendas_codigo_seq;
       public               postgres    false    228            s           0    0    vendas_codigo_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.vendas_codigo_seq OWNED BY public.vendas.codigo;
          public               postgres    false    227            �           2604    16531    fornecedor codigo    DEFAULT     v   ALTER TABLE ONLY public.fornecedor ALTER COLUMN codigo SET DEFAULT nextval('public.fornecedor_codigo_seq'::regclass);
 @   ALTER TABLE public.fornecedor ALTER COLUMN codigo DROP DEFAULT;
       public               postgres    false    218    217            �           2604    16532    item codigo    DEFAULT     j   ALTER TABLE ONLY public.item ALTER COLUMN codigo SET DEFAULT nextval('public.item_codigo_seq'::regclass);
 :   ALTER TABLE public.item ALTER COLUMN codigo DROP DEFAULT;
       public               postgres    false    220    219            �           2604    16533    pessoa codigo    DEFAULT     n   ALTER TABLE ONLY public.pessoa ALTER COLUMN codigo SET DEFAULT nextval('public.pessoa_codigo_seq'::regclass);
 <   ALTER TABLE public.pessoa ALTER COLUMN codigo DROP DEFAULT;
       public               postgres    false    222    221            �           2604    16534    produto codigo    DEFAULT     p   ALTER TABLE ONLY public.produto ALTER COLUMN codigo SET DEFAULT nextval('public.produto_codigo_seq'::regclass);
 =   ALTER TABLE public.produto ALTER COLUMN codigo DROP DEFAULT;
       public               postgres    false    224    223            �           2604    16535    venda codigo    DEFAULT     l   ALTER TABLE ONLY public.venda ALTER COLUMN codigo SET DEFAULT nextval('public.venda_codigo_seq'::regclass);
 ;   ALTER TABLE public.venda ALTER COLUMN codigo DROP DEFAULT;
       public               postgres    false    226    225            �           2604    16580    vendas codigo    DEFAULT     n   ALTER TABLE ONLY public.vendas ALTER COLUMN codigo SET DEFAULT nextval('public.vendas_codigo_seq'::regclass);
 <   ALTER TABLE public.vendas ALTER COLUMN codigo DROP DEFAULT;
       public               postgres    false    227    228    228            V          0    16511 
   fornecedor 
   TABLE DATA           7   COPY public.fornecedor (codigo, descricao) FROM stdin;
    public               postgres    false    217            X          0    16515    item 
   TABLE DATA           _   COPY public.item (codigo, quantidade, valor_parcial, produto_codigo, venda_codigo) FROM stdin;
    public               postgres    false    219            Z          0    16519    pessoa 
   TABLE DATA           ;   COPY public.pessoa (codigo, nome, cpf, funcao) FROM stdin;
    public               postgres    false    221            \          0    16523    produto 
   TABLE DATA           Z   COPY public.produto (codigo, descricao, valor, quantidade, fornecedor_codigo) FROM stdin;
    public               postgres    false    223            ^          0    16527    venda 
   TABLE DATA           n   COPY public.venda (codigo, horario, valor_total, pessoa_codigo_vendedor, pessoa_codigo_comprador) FROM stdin;
    public               postgres    false    225            a          0    16577    vendas 
   TABLE DATA           Q   COPY public.vendas (codigo, data, produto_codigo, quantidade, total) FROM stdin;
    public               postgres    false    228            t           0    0    fornecedor_codigo_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.fornecedor_codigo_seq', 8, true);
          public               postgres    false    218            u           0    0    item_codigo_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.item_codigo_seq', 14, true);
          public               postgres    false    220            v           0    0    pessoa_codigo_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.pessoa_codigo_seq', 1, false);
          public               postgres    false    222            w           0    0    produto_codigo_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.produto_codigo_seq', 47, true);
          public               postgres    false    224            x           0    0    venda_codigo_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.venda_codigo_seq', 2, true);
          public               postgres    false    226            y           0    0    vendas_codigo_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.vendas_codigo_seq', 12, true);
          public               postgres    false    227            �           2606    16537    fornecedor fornecedor_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (codigo);
 D   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_pkey;
       public                 postgres    false    217            �           2606    16539    item item_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (codigo);
 8   ALTER TABLE ONLY public.item DROP CONSTRAINT item_pkey;
       public                 postgres    false    219            �           2606    16541    pessoa pessoa_cpf_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.pessoa
    ADD CONSTRAINT pessoa_cpf_key UNIQUE (cpf);
 ?   ALTER TABLE ONLY public.pessoa DROP CONSTRAINT pessoa_cpf_key;
       public                 postgres    false    221            �           2606    16543    pessoa pessoa_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.pessoa
    ADD CONSTRAINT pessoa_pkey PRIMARY KEY (codigo);
 <   ALTER TABLE ONLY public.pessoa DROP CONSTRAINT pessoa_pkey;
       public                 postgres    false    221            �           2606    16545    produto produto_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (codigo);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public                 postgres    false    223            �           2606    16547    venda venda_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (codigo);
 :   ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_pkey;
       public                 postgres    false    225            �           2606    16585    vendas vendas_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (codigo);
 <   ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
       public                 postgres    false    228            �           1259    16548    idx_venda_horario    INDEX     F   CREATE INDEX idx_venda_horario ON public.venda USING btree (horario);
 %   DROP INDEX public.idx_venda_horario;
       public                 postgres    false    225            �           2620    16549    item trigger_verificar_estoque    TRIGGER     �   CREATE TRIGGER trigger_verificar_estoque BEFORE INSERT ON public.item FOR EACH ROW EXECUTE FUNCTION public.verificar_estoque();
 7   DROP TRIGGER trigger_verificar_estoque ON public.item;
       public               postgres    false    230    219            �           2620    16550    venda trigger_verificar_estoque    TRIGGER     �   CREATE TRIGGER trigger_verificar_estoque BEFORE INSERT ON public.venda FOR EACH ROW EXECUTE FUNCTION public.verificar_estoque();
 8   DROP TRIGGER trigger_verificar_estoque ON public.venda;
       public               postgres    false    230    225            �           2606    16551    item item_produto_codigo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_produto_codigo_fkey FOREIGN KEY (produto_codigo) REFERENCES public.produto(codigo);
 G   ALTER TABLE ONLY public.item DROP CONSTRAINT item_produto_codigo_fkey;
       public               postgres    false    3255    223    219            �           2606    16556    item item_venda_codigo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_venda_codigo_fkey FOREIGN KEY (venda_codigo) REFERENCES public.venda(codigo);
 E   ALTER TABLE ONLY public.item DROP CONSTRAINT item_venda_codigo_fkey;
       public               postgres    false    225    3258    219            �           2606    16561 &   produto produto_fornecedor_codigo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_fornecedor_codigo_fkey FOREIGN KEY (fornecedor_codigo) REFERENCES public.fornecedor(codigo);
 P   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_fornecedor_codigo_fkey;
       public               postgres    false    223    217    3247            �           2606    16566 (   venda venda_pessoa_codigo_comprador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pessoa_codigo_comprador_fkey FOREIGN KEY (pessoa_codigo_comprador) REFERENCES public.pessoa(codigo);
 R   ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_pessoa_codigo_comprador_fkey;
       public               postgres    false    221    3253    225            �           2606    16571 '   venda venda_pessoa_codigo_vendedor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pessoa_codigo_vendedor_fkey FOREIGN KEY (pessoa_codigo_vendedor) REFERENCES public.pessoa(codigo);
 Q   ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_pessoa_codigo_vendedor_fkey;
       public               postgres    false    3253    221    225            �           2606    16586 !   vendas vendas_produto_codigo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_produto_codigo_fkey FOREIGN KEY (produto_codigo) REFERENCES public.produto(codigo) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_produto_codigo_fkey;
       public               postgres    false    228    3255    223            V   C   x�3�t�/�KMNM�/RI-.I�2Dr�2B�:q#s��L���)E��s�a4�&h�M0F��� zW4X      X      x������ � �      Z      x������ � �      \   �   x�}�M
1��/���$mե��� n]�DO�Q������E[���BBy��%o�4��=���I\�ェ��P�b���~4���u9�H4>!ў^)�
5�� b�#�N���7`��B���(y��'��oay��Z!������n����l�X�Z��O>����7�Nu��m��Ӡ=/ص�����u
��      ^      x������ � �      a   3   x��I  �w�t�PN-���K��^��U8N����SF�� ���?û�     