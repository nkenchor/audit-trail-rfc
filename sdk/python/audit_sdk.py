import requests
import uuid
import time

class AuditSDK:
    def __init__(self, ingestion_url, service_name):
        self.ingestion_url = ingestion_url
        self.service_name = service_name

    def emit(self, action, user_id, resource_type, resource_id, metadata=None):
        event = {
            "id": str(uuid.uuid4()),
            "action": action,
            "user_id": user_id,
            "resource_type": resource_type,
            "resource_id": resource_id,
            "timestamp": time.time(),
            "schema_version": "v1",
            "metadata": metadata or {}
        }
        try:
            requests.post(self.ingestion_url, json=event, timeout=3)
        except Exception as e:
            print(f"[AuditSDK] Failed to emit event: {e}")
