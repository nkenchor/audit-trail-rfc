CREATE TABLE redaction_flag (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    audit_log_id UUID NOT NULL REFERENCES audit_logs(id) ON DELETE CASCADE,
    redacted_at TIMESTAMPTZ DEFAULT NOW(),
    redaction_reason TEXT,
    redacted_fields TEXT[], -- Optional: Track which fields were removed
    performed_by UUID, -- Optional: Admin who performed redaction
    is_full_redaction BOOLEAN DEFAULT FALSE
);
