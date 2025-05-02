CREATE TABLE event_context (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    audit_log_id UUID NOT NULL REFERENCES audit_logs(id) ON DELETE CASCADE,
    ip_address INET,
    user_agent TEXT,
    device_id TEXT,
    location TEXT,
    extra_context JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
