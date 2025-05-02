CREATE TABLE event_changes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    audit_log_id UUID NOT NULL REFERENCES audit_logs(id) ON DELETE CASCADE,
    field_name TEXT NOT NULL,
    old_value TEXT,
    new_value TEXT,
    data_type TEXT,
    changed_at TIMESTAMPTZ DEFAULT NOW()
);
