# Opdracht 5 Storage Account


## Key-terms  
Structured data: relational database 
Unstructured data: blob storage  
semi stuctured data: file share 

*Types of Storage in the storage account*

**Blob Storage**:   
Binary Large Object.  
Designed to store any kind of files.
Stored in Containers.  
You can have multiple containers.
Can be all kinds of data. .png, .exe, .mp3, .mp4 

Three storage tiers: 
1. Hot  
2. Cool 
3. Archive


File Storage  
**Table Storage**:  

Designed with a semi-structure in mind so that users and apps can output the semi-structured dataform into tables.  
Stored in table storage.
You can have muliple table storages.
It is a bit like a database where you can store muliple tables with your data. 
Are called NoSQL databases.

- Storage for semi-structured data (NoSQL)
  - Use when you don't need foreign joins, foreign keys, relationships or strict schema.  
  - Designed for fast access (even petabytes of data is accessed quickly if you use compound keys).  
- Many programming interfaces and SDK's



**Queue Storage**: 
When an application has different tasks to complete, and each off those tasks take quite some time to complete, you can store does tasks in the queue storage as seperate *messages*. 
The background services can take a single message and complete the task in the message before taking another message out of the queue. They task can be processed asynchronosly.  
This will offload your front-end application but also allows you to pick more suitable services for the background processing. 

- Storage for small pieces of data (messages).
- Designed for scalable asynchronous processing.


Types of data: 
- Structured: Relational Databases 
- Unstructured: Blob Storage  
- Semi Structured: File Storage



## Opdracht  
Opdracht 1:  
●	Maak een Azure Storage Account. Zorg dat alleen jij toegang hebt tot de data.   
![Alt text](created%20storage%20account.png)

●	Plaats data in een storage service naar keuze via de console (bijvoorbeeld een kattenfoto in Blob storage). 

Eerst een nieuw container aanmaken:
  ![Alt text](create%20new%20container%20in%20storage%20account.png)

Container is aangemaakt:  
![Alt text](container%20gemaakt.png)   

Plaatje toegevoegd via Azure console:
![Alt text](plaatje%20toevoeging%20via%20console.png)

●	Haal de data op naar je eigen computer door middel van de Azure Storage Explorer.  
![Alt text](Storage%20explorer.png)


Opdracht 2:  
●	Maak een nieuwe container aan.  
![Alt text](create%20static%20website%20web%20container.png)   


●	Upload de 4 bestanden die samen de AWS Demo Website vormen.    
![Alt text](Upload%204%20aws%20bestanden.png)

●	Zorg dat Static Website Hosting aan staat.    
Static website enabled:
![Alt text](static%20website%20enabled.png)

●	Deel de URL met een teamgenoot. Zorg ervoor dat zij de website kunnen zien. 



### Gebruikte bronnen

https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website-how-to?tabs=azure-portal

### Ervaren problemen

Het duurde even voordat ik doorhad dat ik bij de instellingen de toestemming aan moest passen dmv wijziging naar switch to access key in de blobcontainer om zo de foto te kunnen uploaden.
![Alt text](wijziging%20naar%20azure%20ad%20user%20account.png)



### Resultaat  

Het is me niet gelukt om de website te laten zien aan de medestudenten. Ik kreeg de foto wel op mijn browser te zien. Ik heb het toen s'avonds nogmaals geprobeerd. Ik heb toen mijn telefoon gebruikt om te zien of de site daarop kwam omdat de site ook zichtbaar was toen ik in een private browser er naartoe ging. In eeste instantie lukte het niet maar na het veranderen van instelling lukte het wel. Ik heb de opdracht nogmaals in het weekend gedaan. Helaas lukte het mij toen niet meer om de website zichtbaar te krijgen op mijn telefoon. Zodra ik tijd heb ga ik het nogmaals proberen. 
