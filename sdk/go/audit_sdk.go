package audit

import (
    "bytes"
    "encoding/json"
    "net/http"
    "time"

    "github.com/google/uuid"
)

type AuditEvent struct {
    ID            string                 `json:"id"`
    Action        string                 `json:"action"`
    UserID        string                 `json:"user_id"`
    ResourceType  string                 `json:"resource_type"`
    ResourceID    string                 `json:"resource_id"`
    Timestamp     time.Time              `json:"timestamp"`
    SchemaVersion string                 `json:"schema_version"`
    Metadata      map[string]interface{} `json:"metadata"`
}

func Emit(ingestionURL string, event AuditEvent) error {
    event.ID = uuid.New().String()
    event.Timestamp = time.Now()
    event.SchemaVersion = "v1"

    body, _ := json.Marshal(event)
    _, err := http.Post(ingestionURL, "application/json", bytes.NewBuffer(body))
    return err
}
