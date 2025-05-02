# Audit Trail System RFC

A scalable and secure audit trail system designed to capture user activity across microservices. This repository contains the architectural design, technical rationale, and implementation plan for a GDPR-compliant logging service aimed at maintaining traceability, data integrity, and operational oversight.

## Table of Contents

- [Overview](#overview)
- [Objectives](#objectives)
- [Repository Structure](#repository-structure)
- [Key Components](#key-components)
- [Technology Stack](#technology-stack)
- [How to Use This Repo](#how-to-use-this-repo)
- [Quickstart](#quickstart)
- [Assumptions](#assumptions)
- [Future Enhancements](#future-enhancements)
- [Author](#author)


## Overview

This repository contains the design and implementation plan for an Audit Trail System that captures, stores, and manages critical user actions across the platform. The objective of this system is to ensure security, traceability, and compliance with data governance standards such as GDPR and SOC 2.

The RFC outlines the architecture, data flow, backend and frontend instrumentation, database schema, deployment considerations, and security strategy. It is written from the perspective of an Engineering Manager responsible for guiding the system's design and delivery.

## Objectives

- Capture high-value events including logins, data access, profile updates, administrative actions, and security-sensitive changes.
- Ensure audit logs are immutable, versioned, and queryable for internal investigation and compliance audits.
- Support schema evolution and long-term retention with redaction and expiration capabilities aligned with regulatory standards.
- Minimize integration friction for engineering teams by offering a shared SDK and clear contract-based schema definitions.
- Enable scalable ingestion, storage, and querying of logs using distributed infrastructure and partitioned storage design.


## Repository Structure

```
audit-trail-rfc/
│
├── RFC.md
├── README.md
│
├── diagrams/
│   ├── system-architecture.png         
│   ├── user-flow.png                  
│   ├── audit-events-erd.png          
│   └── header-banner.png            
│
├── schema/
│   ├── schema_versions.sql           
│   ├── event_changes.sql      
│   ├── audit_logs.sql                
│   ├── user.sql   
│   ├── redaction_flag.sql   
│   ├── event_context.sql            
│               
│
├── sdk/
│   ├── python/
│   │   └── audit_sdk.py              
│   ├── nodejs/
│   │   └── audit-sdk.js               
│   └── go/
│       └── audit_sdk.go              
│
├── scripts/
│   ├── validate_event_schema.py       
│   ├── test_data_generator.py        
│   ├── replay_audit_logs.py          
│   ├── smoke_test.sh                 
│   ├── notify.sh                     
│   └── tests/
│       ├── test_partition_creation.sql  
│       └── test_redaction.sql           
│
├── infra/
│   ├── terraform/
│   │   └── main.tf                   
│   ├── helm/
│   │   └── audit-logger-chart/       
│   └── docker-compose.yml            

```

## Key Components

1. **Backend Instrumentation SDK**
   - Captures standardized audit events across microservices.
   - Handles schema validation, metadata enrichment, and publishing to the queue.

2. **Frontend Relays (Optional)**
   - Secure backend relay endpoints to record client-side UI actions (e.g., download clicks, modal views).

3. **Audit Logging Service**
   - Consumes audit events from the message queue.
   - Validates and persists structured logs to an immutable store (e.g., PostgreSQL with partitioning).

4. **Database**
   - PostgreSQL with time-based partitioning for efficient writes and queries.
   - Enforces strict typing, indexing, and schema versioning.

5. **Security and Compliance Layer**
   - Redaction, expiration, and user-based deletion tools.
   - Encryption support and RBAC for querying and management.

## Technology Stack

- **Backend Framework**: FastAPI (preferred), Go, or Node.js (Express)
- **Messaging Layer**: Apache Kafka or AWS Kinesis
- **Storage**: PostgreSQL with time-based partitioning
- **Optional Search Index**: Elasticsearch for advanced filtering
- **Long-Term Archival**: Amazon S3
- **CI/CD & DevOps**: GitHub Actions, Docker, Kubernetes (optional)
- **Infrastructure-as-Code**: Terraform, Helm
- **Visualization**: Diagrams.net, Mermaid.js


## How to Use This Repo

- [RFC.md](./RFC.md): Full technical specification
- [diagrams/](./diagrams): System architecture and user flow diagrams
- [schema/](./schema): Database schema definitions
- [samples/](./samples): Example audit log entries

1. Open RFC.md to review the full design document.
2. Review diagrams/ for the system and user flow diagrams.
3. Explore schema/ for the PostgreSQL schema.
4. Use samples/ to view example audit log entries.
5. Clone the repository and adapt the structure to your implementation needs.

## Quickstart

To preview the audit schema locally:

```bash
psql < schema/audit_logs.sql
```

To view sample log format:

```bash
cat samples/audit_log_example.json
```

## Assumptions

- The system operates internally but is designed to extend to customer-facing audit dashboards.
- Kafka or Kinesis is available for event buffering and decoupled processing.
- Events follow a shared schema with version control and validation pipelines.
- Logs must comply with GDPR, SOC 2, HIPAA, and RTBF requirements.
- Deployment targets a cloud-native environment with scalable managed services.

## Future Enhancements

- Add support for Elasticsearch for fast search and filtering.
- Integrate real-time monitoring and anomaly detection on log events.
- Expose a user-facing audit query API for customer access logs.
- Add S3-based archival and restore support for long-term logs.
- Include a redaction policy editor and data compliance dashboard.

## Author

Prepared by Nkenchor Osemeke as part of a technical leadership assessment for the role of Engineering Manager.

