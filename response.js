function success(data, message = 'success') {
  return {
    code: 0,
    message: message,
    data: data
  };
}

function error(message, code = -1) {
  return {
    code: code,
    message: message,
    data: null
  };
}

function generateId(prefix = '') {
  return prefix + Date.now().toString(36) + Math.random().toString(36).substr(2, 9);
}

function parseJsonField(value, defaultValue = null) {
  if (!value) return defaultValue;
  try {
    return JSON.parse(value);
  } catch (e) {
    return defaultValue;
  }
}

function calculateDistance(lat1, lng1, lat2, lng2) {
  const rad = function (d) { return d * Math.PI / 180.0; };
  const R = 6371;
  const a = rad(lat1) - rad(lat2);
  const b = rad(lng1) - rad(lng2);
  const s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) + Math.cos(rad(lat1)) * Math.cos(rad(lat2)) * Math.pow(Math.sin(b / 2), 2)));
  return Math.round(s * R * 1000);
}

module.exports = {
  success,
  error,
  generateId,
  parseJsonField,
  calculateDistance
};
