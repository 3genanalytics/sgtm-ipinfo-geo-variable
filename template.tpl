___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "IPinfo Geo Lookup",
  "description": "Returns geographic information for the incoming request IP using the IPinfo API.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "token",
    "displayName": "IPinfo Access Token",
    "simpleValueType": true
  },
  {
    "type": "SELECT",
    "name": "outputField",
    "displayName": "Output Field",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "city",
        "displayValue": "City"
      },
      {
        "value": "region",
        "displayValue": "Region"
      },
      {
        "value": "country",
        "displayValue": "Country"
      },
      {
        "value": "postal",
        "displayValue": "Postal Code"
      },
      {
        "value": "ip",
        "displayValue": "IP Address"
      },
      {
        "value": "timezone",
        "displayValue": "Timezone"
      },
      {
        "value": "loc",
        "displayValue": "Coordinates"
      }
    ],
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_SERVER___

const getRemoteAddress = require('getRemoteAddress');
const sendHttpGet = require('sendHttpGet');
const JSON = require('JSON');
const encodeUriComponent = require('encodeUriComponent');

const ip = getRemoteAddress();

if (!ip) {
  return undefined;
}

const token = data.token;

if (!token) {
  return undefined;
}

const url =
  'https://ipinfo.io/' +
  encodeUriComponent(ip) +
  '/json?token=' +
  encodeUriComponent(token);

return sendHttpGet(url, {
  timeout: 2000
}).then(
  function(response) {

    if (
      response.statusCode < 200 ||
      response.statusCode >= 300 ||
      !response.body
    ) {
      return undefined;
    }

    const geo = JSON.parse(response.body);

    if (!geo) {
      return undefined;
    }

    if (data.outputField === 'city') {
      return geo.city || undefined;
    }

    if (data.outputField === 'region') {
      return geo.region || undefined;
    }

    if (data.outputField === 'country') {
      return geo.country || undefined;
    }

    if (data.outputField === 'postal') {
      return geo.postal || undefined;
    }

    if (data.outputField === 'timezone') {
      return geo.timezone || undefined;
    }

    if (data.outputField === 'loc') {
      return geo.loc || undefined;
    }

    if (data.outputField === 'ip') {
      return geo.ip || ip;
    }

    return undefined;
  },
  function() {
    return undefined;
  }
);


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "X-Forwarded-For"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "Forwarded"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "remoteAddressAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://ipinfo.io/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []
setup: ''


___NOTES___

Created on 23.08.2026 23:53:15


