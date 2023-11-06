from kafka import KafkaProducer
from json import dumps
from fastapi import FastAPI
from typing import Optional

app = FastAPI()

# Configuração do Kafka Producer
producer = KafkaProducer(
    bootstrap_servers=['kafka:9092'], 
    value_serializer=lambda x: dumps(x).encode('utf-8')
)

@app.get("/health")
async def read_root():
    return {"Hello": "Shipay"}

@app.get("/items/{item_id}")
async def read_item(item_id: int, q: Optional[str] = None):
    try:
        # Tente enviar a mensagem para o Kafka
        producer.send('items_topic', {'item_id': item_id, 'q': q})
        # Aguarde a mensagem ser enviada com sucesso
        producer.flush()
        return {"item_id": item_id, "q": q}
    except Exception as e:
        # Em caso de erro, logue o erro
        print(f"Failed to send message to Kafka: {e}")
        # Retorne uma resposta de erro
        return {"error": "Failed to send message to Kafka"}
