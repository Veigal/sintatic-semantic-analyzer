# Analisador sintático-semântico

Projeto para desenvolvimento de uma aplicação de análise sintática e léxica para a disciplina de Tradutores Unisinos-2020.

(Adicionar imagens)

### Ferramentas utilizadas:

- Software [ANTLR](https://www.antlr.org/)

### Como utilizar:

- Realizar o download da aplicação para utilização;
- Instalar ou executar o arquivo .jar;
- Executar o arquivo.

(Adicionar passos de como executar)

### Materiais de consulta:

Explicações sobre a aplicação ANTLR: https://github.com/antlr/antlr4/blob/master/doc/getting-started.md

### Exemplo de funcionamento

#### Input

```
b := 4 / (2+3);
a := b + c * 1;

if a = 1 then   
    if b = 0 then 
        a := 0;
else b := 1;
```

#### Output

```
resultado: variável b = 0,8
resultado: variável a = 0,8 
resultado: expresão logica = false 
resultado: variável b = 1  
```


