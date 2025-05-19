/// This class is used for mocking data for testing purposes.
class MyMockResponses {
  static const Map<String, dynamic> login = {
    "success": true,
    "user": {
      "name": "Nome de teste do usuário",
      "profile": "Promotor",
      "tasks": [
        {
          "id": 1,
          "task_name": "Tarefa número 1",
          "description": "Informe o nome e preço do produto",
          "fields": [
            {
              "id": 1,
              "label": "Nome do produto",
              "required": true,
              "field_type": "text",
            },
            {
              "id": 2,
              "label": "Informe o preço",
              "required": true,
              "field_type": "mask_price",
            }
          ]
        },
        {
          "id": 2,
          "task_name": "Tarefa número 2",
          "description": "Informe o nome do produto e data de vencimento",
          "fields": [
            {
              "id": 1,
              "label": "Nome do produto",
              "required": true,
              "field_type": "text",
            },
            {"id": 2, "label": "Informe o preço", "required": true, "field_type": "mask_date"}
          ]
        },
        {
          "id": 3,
          "task_name": "Tarefa número 3",
          "description": "Informe o nome do cliente e nome da loja",
          "fields": [
            {"id": 1, "label": "Nome do cliente", "required": true, "field_type": "text"},
            {
              "id": 2,
              "label": "nome da loja",
              "required": true,
              "field_type": "text",
            }
          ]
        }
      ]
    }
  };
}
