# Shadow Drive Swift Packaage

![Shadow Drive GenesysGo API](https://github.com/denizTutuncu/ShadowDriveSwiftPackage/blob/main/Media/ShadowAPIs.png?raw=true)

Introducing the Shadow Drive Swift Package Project

Hello there! 

We're excited to introduce the Shadow Drive Swift Package Project. Our aim is simple: to create a user-friendly and seamless Swift package that makes it easier for Swift 
developers to work with Shadow Drive APIs. With our package, we're here to simplify your Swift development process and ensure it's as smooth as possible. Stay with us as we embark on this 
journey to enhance your Swift development experience with Shadow Drive.

## Creates a new storage account

### Story: Customer requests to create a new storage account

### Narrative #1

```
As an online customer
I want the app to create a new storage account
So I can start to upload my files
```

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
When the customer requests to create a new storage account
Then the app should create a new storage account
And replace the cache with adding the storage account
```

### Narrative #2

```
As an offline customer
I want the app to show the latest saved version of storage accounts
So I can always see my storage accounts
```

#### Scenarios (Acceptance criteria)

```
Given the customer doesn't have connectivity
  And there’s a cached version of the accounts
  And the cache is less than seven days old
 When the customer requests to see the feed
 Then the app should display the latest accounts saved

Given the customer doesn't have connectivity
  And there’s a cached version of the accounts
  And the cache is seven days old or more
 When the customer requests to see the accounts
 Then the app should display an error message

Given the customer doesn't have connectivity
  And the cache is empty
 When the customer requests to see the accounts
 Then the app should display an error message
```

## Use Cases

### Create Storage Account From Remote Use Case

#### Data:
- TRANSACTION (Serialized create storage account transaction that's partially signed by the storage account owner)

#### Primary course (happy path):
1. Execute "Create New Storage" command with above data.
2. System downloads data from the URL.
3. System validates downloaded data.
4. System creates created storage accounts from valid data.
5. System delivers created storage accounts.

#### Invalid data – error course (sad path):
1. System delivers invalid data error.

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---

### Load Storage Accounts From Cache Use Case

#### Primary course:
1. Execute "Load Storage Accounts" command with above data.
2. System retrieves storage accounts data from cache.
3. System validates cache is less than seven days old.
4. System creates storage accounts from cached data.
5. System delivers storage accounts.

#### Retrieval error course (sad path):
1. System delivers error.

#### Expired cache course (sad path): 
1. System delivers no feed images.

#### Empty cache course (sad path): 
1. System delivers no feed images.

---

### Validate Storage Accounts Cache Use Case

#### Primary course:
1. Execute "Validate Cache" command with above data.
2. System retrieves storage accounts data from cache.
3. System validates cache is less than seven days old.

#### Retrieval error course (sad path):
1. System deletes cache.

#### Expired cache course (sad path): 
1. System deletes cache.

---

### Cache New Storage Accounts Use Case

#### Data:
- New Storage Account

#### Primary course (happy path):
1. Execute "Save New Storage Account" command with above data.
2. System deletes old cache data.
3. System encodes new storage account.
4. System timestamps the new cache.
5. System saves new cache data.
6. System delivers success message.

#### Deleting error course (sad path):
1. System delivers error.

#### Saving error course (sad path):
1. System delivers error.

---

## Flowchart

![Create new storage flowchart](https://github.com/denizTutuncu/ShadowDriveSwiftPackage/blob/main/Media/NewStorageFlowchart.drawio.png?raw=true)

## Model Specs

### New Storage

| Property               | Type                |
|------------------------|---------------------|
| `shadowBucket`         | `String`            |
| `transactionSignature` | `String`            |

### Payload contract

```
POST /storage-account

200 RESPONSE

{
  "shdw_bucket": "string",
  "transaction_signature": "string"
}
```

---

Other APIs ...

---

## App Architecture

![App Architecture](https://github.com/denizTutuncu/ShadowDriveSwiftPackage/blob/main/Media/ShadowDrive.drawio.png?raw=true)

