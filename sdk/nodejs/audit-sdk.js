const axios = require('axios');
const { v4: uuidv4 } = require('uuid');

class AuditSDK {
  constructor(ingestionUrl, serviceName) {
    this.ingestionUrl = ingestionUrl;
    this.serviceName = serviceName;
  }

  async emit(action, userId, resourceType, resourceId, metadata = {}) {
    const event = {
      id: uuidv4(),
      action,
      user_id: userId,
      resource_type: resourceType,
      resource_id: resourceId,
      timestamp: new Date().toISOString(),
      schema_version: "v1",
      metadata
    };

    try {
      await axios.post(this.ingestionUrl, event);
    } catch (error) {
      console.error("[AuditSDK] Failed to emit event:", error.message);
    }
  }
}

module.exports = AuditSDK;
