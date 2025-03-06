# Desafios para desenvolvedores SPC Grafeno

Desafios para desenvolvedores da SPC Grafeno.

Esta é uma etapa importante do processo de formação de equipe e esperamos que você aproveite este momento para que possamos conhecer melhor sua habilidades técnicas. Para isso, seguem algumas recomendações:
- Não copie da internet.
- Não copie de outro candidato.
- Dedique tempo suficiente durante a solução do desafio e foque no que é importante para funcionar, pense como um produto que precisa ser entregue para o cliente final.
- Leia com atenção o desafio proposto antes de iniciar a solução.

## Desafio proposto: Encurtador de URL

Implementar um serviço que permita encurtar URLs a fim de torná-las mais legíveis e fáceis de compartilhar com outras pessoas.

O serviço deve ser capaz de encurtar uma URL longa, desfazer o encurtamento quando a URL curta for acessada e redirecionar para a URL original cadastrada pelo usuário.

Envie também quaiquer documentações da solução, endpoints, arquitetura, etc que você tenha utilizado durante o desenvolvimento pois será um plus.

### Requisitos de negócio
- No cadastro, receber uma URL longa como parâmetro obrigatório.
- O encurtamento deve ser composto por no mínimo 5 e no máximo 10 caracteres.
- Apenas letras e números devem ser utilizados na composição da URL curta.
- A URL encurtada poderá ter data de expiração, neste caso, considere receber e validar esse parâmetro opcional.
- Ao acessar uma URL curta com data de expiração passada, devolver resposta como registro não encontrado.
- Não é necessário frontend, apenas API.

### Requisitos técnicos
- Deve ser uma API em json.
- Considere a melhor escolha dos verbos HTTP para cada cenário.
- Não é necessário se preocupar com autenticação, mas se quiser implementar, nos mostre como você faria.
- Utilize o banco de dados e outras tecnologias de sua escolha para a compor a solução proposta.
- É necessário que a sua solução execute em Docker.

## Entrega e avaliação do desafio

Faça um fork deste repositório, crie uma branch com a solução proposta e submeta o PR para o upstream.

Queremos que você mostre a melhor solução que você pode criar.

Boas práticas de desenvolvimento são importantes e serão analisadas, como: testes, DRY, 12-factor App, etc. Também vamos analisar a organização do código de forma geral.

É esperado que sua solução tenha um README com instruções de setup e consigamos executá-la em poucos passos sem complicações.

É preferível que você utilize Ruby on Rails, pois faz parte da nossa principal stack de desenvolvimento, mas você também pode resolver com outras linguagens e frameworks das quais se sente mais confortável.

Você tem o prazo de 3 dias corridos a partir do recebimento do desafio, e a entrega é considerada com a abertura do PR.

## Dúvidas

Em caso de dúvidas, entre em contato com: guilherme.pereira@spcgrafeno.com.br ou marcos.cordeiro@spcgrafeno.com.br
