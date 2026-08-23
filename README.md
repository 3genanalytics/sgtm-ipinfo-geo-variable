# IPinfo Geo Lookup for Server-Side Google Tag Manager

A Server-Side Google Tag Manager variable template that retrieves geographic information for the incoming request IP address using the IPinfo API.

## Features

The template can return:

* City
* Region
* Country
* Postal Code
* Timezone
* Coordinates
* IP Address

## Requirements

* Google Tag Manager Server Container
* IPinfo account
* IPinfo Access Token

You can create an account and get your access token from:

https://ipinfo.io/

## Installation

Install the template from the Google Tag Manager Community Template Gallery or import the `template.tpl` file manually into your Server-Side GTM container.

Then go to:

**Variables → New → Variable Configuration → IPinfo Geo Lookup**

## Configuration

Enter your IPinfo Access Token.

Example:

```text
IPinfo Access Token:
xxxxxxxxxxxxxxxx
```

Select the value you want the variable to return from the **Output Field** dropdown.

Available values:

```text
City
Region
Country
Postal Code
Timezone
Coordinates
IP Address
```

## Example

Assume the incoming request is associated with this IPinfo response:

```json
{
  "ip": "1.2.3.4",
  "city": "Istanbul",
  "region": "Istanbul",
  "country": "TR",
  "postal": "34000",
  "timezone": "Europe/Istanbul",
  "loc": "41.0082,28.9784"
}
```

You can create variables such as:

```text
IPinfo - City
Output Field: City

Result:
Istanbul
```

```text
IPinfo - Country
Output Field: Country

Result:
TR
```

```text
IPinfo - Postal
Output Field: Postal Code

Result:
34000
```

## Meta Conversions API Example

The template can be used to enrich Meta Conversions API requests with geographic information.

Create these Server-Side GTM variables:

```text
IPinfo - City
IPinfo - Region
IPinfo - Country
IPinfo - Postal
```

Then create an **Augment Event Transformation** and map:

```text
user_data.address.city
= {{IPinfo - City}}

user_data.address.region
= {{IPinfo - Region}}

user_data.address.country
= {{IPinfo - Country}}

user_data.address.postal_code
= {{IPinfo - Postal}}
```

Apply the Transformation to your Meta Conversions API tag.

The Meta tag can then use these values as:

```text
ct
st
country
zp
```

## How It Works

The template:

```text
Incoming Server-Side GTM request
        ↓
Client IP address
        ↓
IPinfo API request
        ↓
Geographic response
        ↓
Selected Output Field
        ↓
Server-Side GTM Variable
```

The lookup happens server-side, so browser CSP restrictions do not affect the IPinfo request.

## Permissions

The template requests access to:

```text
Remote IP Address
Forwarded header
X-Forwarded-For header
```

It is only allowed to send HTTP requests to:

```text
https://ipinfo.io/*
```

## Privacy

This template sends the incoming request IP address to IPinfo in order to retrieve geographic information.

Make sure your implementation complies with your privacy policy, consent requirements, applicable data protection regulations, and IPinfo's terms of service.

## API Usage

IPinfo API limits and pricing depend on the IPinfo plan associated with your access token.

Check current plans and API limits at:

https://ipinfo.io/

## License

Apache License 2.0
