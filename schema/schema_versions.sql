CREATE TABLE schema_versions (
    version_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    version_name TEXT NOT NULL UNIQUE,  -- e.g. v1.0, v1.1-beta
    description TEXT,
    schema JSONB NOT NULL,              -- Optional: store full schema definition
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
