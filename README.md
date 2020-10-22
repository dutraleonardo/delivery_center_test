# DeliveryCenterTest

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Como rodar o projeto?

#### Clone o repositório
```
git clone https://github.com/dutraleonardo/delivery_center_test.git
cd delivery_center_test
```

#### Rodar com docker
```
  chmod +x entrypoint.sh
  docker-compose build
  docker-compose up
```

#### Rodar sem docker
* Ver o inicio da documentaçao

#### Testar
* Postman -> importar o arquivo e executar a requisição delivery_center_test.postman_collection.json
* cURL -> executar o código abaixo no terminal
 ```
 curl -X POST \
  http://localhost:4000/api/orders \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: daabe393-7eec-48b0-b007-57e6eb3fb2d9' \
  -H 'cache-control: no-cache' \
  -d '{
  "id": 9987071,
  "store_id": 282,
  "date_created": "2019-06-24T16:45:32.000-04:00",
  "date_closed": "2019-06-24T16:45:35.000-04:00",
  "last_updated": "2019-06-25T13:26:49.000-04:00",
  "total_amount": 49.9,
  "total_shipping": 5.14,
  "total_amount_with_shipping": 55.04,
  "paid_amount": 55.04,
  "expiration_date": "2019-07-22T16:45:35.000-04:00",
  "order_items": [
    {
      "item": {
        "id": "IT4801901403",
        "title": "Produto de Testes"
      },
      "quantity": 1,
      "unit_price": 49.9,
      "full_unit_price": 49.9
    }
  ],
  "payments": [
    {
      "id": 12312313,
      "order_id": 9987071,
      "payer_id": 414138,
      "installments": 1,
      "payment_type": "credit_card",
      "status": "paid",
      "transaction_amount": 49.9,
      "taxes_amount": 0,
      "shipping_cost": 5.14,
      "total_paid_amount": 55.04,
      "installment_amount": 55.04,
      "date_approved": "2019-06-24T16:45:35.000-04:00",
      "date_created": "2019-06-24T16:45:33.000-04:00"
    }
  ],
  "shipping": {
    "id": 43444211797,
    "shipment_type": "shipping",
    "date_created": "2019-06-24T16:45:33.000-04:00",
    "receiver_address": {
      "id": 1051695306,
      "address_line": "Rua Fake de Testes 3454",
      "street_name": "Rua Fake de Testes",
      "street_number": "3454",
      "comment": "teste",
      "zip_code": "85045020",
      "city": {
        "name": "Cidade de Testes"
      },
      "state": {
        "name": "São Paulo"
      },
      "country": {
        "id": "BR",
        "name": "Brasil"
      },
      "neighborhood": {
        "id": null,
        "name": "Vila de Testes"
      },
      "latitude": -23.629037,
      "longitude": -46.712689,
      "receiver_phone": "41999999999"
    }
  },
  "status": "paid",
  "buyer": {
    "id": 136226073,
    "nickname": "JOHN DOE",
    "email": "john@doe.com",
    "phone": {
      "area_code": 41,
      "number": "999999999"
    },
    "first_name": "John",
    "last_name": "Doe",
    "billing_info": {
      "doc_type": "CPF",
      "doc_number": "09487965477"
    }
  }
}'
 ```

  
## Diagrama de Banco de Dados
![Modelo_ER](https://github.com/dutraleonardo/delivery_center_test/blob/master/delivery-center-db-diagram.png)

## O Desafio

### Teste de Dev Backend usando Elixir!

O objetivo deste teste é avaliar a organização do seu código, e como você estrutura uma solução simples e eficiente baseada em requisitos simples.

#### Caso 

O Delivery Center está em plena expansão de suas operações pelo Brasil, com planos audaciosos de operar nas maiores capitais ainda em 2019. 
Um dos passos dessa expansão é ampliar a captação de pedidos de diversos canais, sejam eles de `food`, `goods`, `FMCG`, `services`, entre outros. 
O mais recente movimento para alcançar este objetivo é a integração a um dos maiores marketplaces do país. Esta integração permitirá captar pedidos dos nossos lojistas que operam neste canal
e operá-los em nossa estrutura logística, entregando pedidos em `same hour / same day`.

Para viabilizar esta integração, um dos passos importantes é realizar o `parsing` dos dados que vêm da API deste canal para a nossa estrutura, garantindo que 
a nossa operação irá receber de forma correta e clara as informações necessárias para entregar o pedido na casa do cliente, no endereço correto, para o cliente correto, 
com clareza dos valores a serem pagos, formas de pagamento, entre outras informações. 

Vale ressaltar que sem as informações corretas a operação do Delivery Center pode ter prejuízos no envio, gerando custos extras de envio e insatisfação do cliente. 

#### Informações Complementares

O `JSON` a seguir representa um payload com dados fictícios de um pedido de compra de alguns produtos por um cliente.

  - Utilizar a linguagem Elixir, mas pode escolher qualquer framework / libs (mix) que quiser para auxiliar no desenvolvimento, como, por exemplo: Phoenix, etc. Se preferir, pode não usar nenhum. Essa escolha não irá influenciar na avaliação.
  - Fazer um parse do **Payload** abaixo.
  - Enviar para uma API REST (https://delivery-center-recruitment-ap.herokuapp.com/), no formato descrito no item **Processamento**, que fará algumas validações e retornará o resultado.
  - Enviar com o Header 'X-Sent' com a data/hora atual no formato: 09h25 - 24/10/19.
  - Registrar os dados do pedido em um banco de dados
      - Nesse caso você deve também incluir no seu código o schema do banco de dados.
  - Deixar o código disponível em algum repositório público (github,  bitbucket, etc...)
  - Enviar o link do repositório para o e-mail **testes.tech@deliverycenter.com**
  
  :warning: Lembre-se de manter seu código limpo (Clean Code = :heart:), seguindo as convenções da comunidade e, não precisamos nem mencionar, escreva testes.

#### Payload


```json
{
  "id": 9987071,
  "store_id": 282,
  "date_created": "2019-06-24T16:45:32.000-04:00",
  "date_closed": "2019-06-24T16:45:35.000-04:00",
  "last_updated": "2019-06-25T13:26:49.000-04:00",
  "total_amount": 49.9,
  "total_shipping": 5.14,
  "total_amount_with_shipping": 55.04,
  "paid_amount": 55.04,
  "expiration_date": "2019-07-22T16:45:35.000-04:00",
  "total_shipping": 5.14,
  "order_items": [
    {
      "item": {
        "id": "IT4801901403",
        "title": "Produto de Testes"
      },
      "quantity": 1,
      "unit_price": 49.9,
      "full_unit_price": 49.9
    }
  ],
  "payments": [
    {
      "id": 12312313,
      "order_id": 9987071,
      "payer_id": 414138,
      "installments": 1,
      "payment_type": "credit_card",
      "status": "paid",
      "transaction_amount": 49.9,
      "taxes_amount": 0,
      "shipping_cost": 5.14,
      "total_paid_amount": 55.04,
      "installment_amount": 55.04,
      "date_approved": "2019-06-24T16:45:35.000-04:00",
      "date_created": "2019-06-24T16:45:33.000-04:00"
    }
  ],
  "shipping": {
    "id": 43444211797,
    "shipment_type": "shipping",
    "date_created": "2019-06-24T16:45:33.000-04:00",
    "receiver_address": {
      "id": 1051695306,
      "address_line": "Rua Fake de Testes 3454",
      "street_name": "Rua Fake de Testes",
      "street_number": "3454",
      "comment": "teste",
      "zip_code": "85045020",
      "city": {
        "name": "Cidade de Testes"
      },
      "state": {
        "name": "São Paulo"
      },
      "country": {
        "id": "BR",
        "name": "Brasil"
      },
      "neighborhood": {
        "id": null,
        "name": "Vila de Testes"
      },
      "latitude": -23.629037,
      "longitude": -46.712689,
      "receiver_phone": "41999999999"
    }
  },
  "status": "paid",
  "buyer": {
    "id": 136226073,
    "nickname": "JOHN DOE",
    "email": "john@doe.com",
    "phone": {
      "area_code": 41,
      "number": "999999999"
    },
    "first_name": "John",
    "last_name": "Doe",
    "billing_info": {
      "doc_type": "CPF",
      "doc_number": "09487965477"
    }
  }
}
```

#### Processamento

Abaixo um exemplo do payload esperado, casando com os dados informados no payload acima.

  - **Todos os campos são obrigatórios**:
  - Caso ocorra algum erro, os mesmos deverão ser tratados.
  - Não é necessário o desenvolvimento de uma interface gráfica.

```JSON
{
        "externalCode": "9987071",
        "storeId": 282,
        "subTotal": "49.90",
        "deliveryFee": "5.14",
        "total": "55.04",
        "country": "BR",
        "state": "SP",
        "city": "Cidade de Testes",
        "district": "Bairro Fake",
        "street": "Rua de Testes Fake",
        "complement": "galpao",
        "latitude": -23.629037,
        "longitude":  -46.712689,
        "dtOrderCreate": "2019-06-27T19:59:08.251Z",
        "postalCode": "85045020",
        "number": "0",
        "customer": {
            "externalCode": "136226073",
            "name": "JOHN DOE",
            "email": "john@doe.com",
            "contact": "41999999999",
        },
        "items": [
            {
                "externalCode": "IT4801901403",
                "name": "Produto de Testes",
                "price": 49.9,
                "quantity": 1,
                "total": 49.9,
                "subItems": []
            }
        ],
        "payments": [
            {
                "type": "CREDIT_CARD",
                "value": 55.04
            }
        ]
    }
```

