# **Keep Fresh**

![header](/photos/keepfresh-long.png "header")

### Team
**Tech Lead:** Connor Fong<br>
**Developers:** Adrian Viquez, Alan Yang, Wren Liang, Noor Khan, Nanda Syahrasyad, Andrew Zulaybar<br>
**Marketing Strategist:** Sang Le<br>
**UX/UI Designers:** Sandy Co, Jessica del Rosario

### Timeline
**Minimum viable product:** 4 months<br>
**Full finished product:** 8 months</br>

### Technology
**Languages:** Swift, Typescript</br>
**Databases:** Mongo, Postgres </br>
**Design Tools:** Figma, Sketch, InVision</br>
 </br>
---

## Background
Keepfresh is an iOS app built with UBC Launchpad, a student-run software engineering team devoted to building software projects in a collaborative, professional environment.
We collaborated as a team of 7 developers, a marketing strategist, and 2 UX/UI designers to create Keepfresh.

## Project Goal
Build, design, and conduct research for an iOS app that will allow users to track the food in their homes, see when items are expiring, and find recipes based on their inventory.

## The Problem
Food waste is a huge problem in Canada.

> **50%** of food in Canada is wasted every year, equating to ~ **$17 billion**.
>> **60%** of participants were not at all aware of Canada’s food waste problem.

Because of this, our team wanted to find a solution to lessen the amount of food waste created every year.


## Pain Points
To learn more about the current food waste situation and to understand people living in Canada, we interviewed 20 people to ask them about their food habits at home.<br>
The most prominent pain points of people are:
- Staying within budget when buying food
- Planning for buying groceries when unsure what recipes to cook
- Keeping track of food that is about to expire


## Solutions
We created 2 main solutions to attempt to solve our users’ problems:
1. **Pantry page:** The 'pantry' page allows users to see all of the food that they currently have, with notifications of expiry, listed in order of nearest to furthest expiration.
2. **Recipes page:** Users will be able to find recipes automatically suggested based on what they have in their fridge


## Target Users
For our minimum viable product, our main target users were individuals living on their own or not sharing food with roommates/family members, so that we could effectively solve the problems that this demographic was having in terms of food management, and further expand on these solutions with time.<br>

In the future, we would like this product to also help families and those who share their food with others to keep track of their food, so that multiple users can add and remove items from the same fridge.

## User Research/Design Process
#### Low-fi design research
We surveyed a wide variety of students and working adults to gain a deeper understanding of the main problems that people were having when trying to keep track of and use their food before it expired - this helped us to develop our main user flows and figure out what functions would be most important.
#### Mid-fi user testing
In order to validate our user flows and mid-fi designs, we created task scenarios and conducted A/B testing. This helped us isolate any parts of the user flows that might be confusing, and decide on which iterations of certain interfaces to continue to improve on.

## Development
#### Front-end
Using mockups and wireframes from our design team, we built a native iOS application using Swift and Xcode. Our development went through numerous iterations, first building out boilerplate to display mock data and support our planned view hierarchies, then integrating our backend APIs, and finally implementing hifi design details.
#### Back-end
We took a microservices architectural approach with scalability, separation of concerns, and parallel development in mind. For the first 3-4 months, we each worked on a specific microservice (the API gateway, user authentication, ingredient storage, and recipe storage).<br>
In our second term of development, we built the recommendation service collaboratively since that involved domain knowledge from all services. Taking on tasks across each service also allowed us to become familiar with how the parts worked together as a whole.

We eventually developed a service that suggests recipes based on the ingredients that a user has. Here’s how the algorithm works:
1. The front end sends a GET request to the suggestion service with the given user ID.
2. The suggestion service makes a call to the ingredient service to retrieve the ingredients that user ID has.
3. The suggestion service then creates a hash for that list of ingredients. The hash is a bit string where each bit is assigned a specific ingredient - the bit is a 1 if the list contains that ingredient, and a 0 otherwise. Each recipe in the recipe DB contains a similar hash.
4. The suggestion service then fetches 25 random recipes from the DB and computes a similarity score for each recipe retrieved. If the score is above a particular threshold, we add that recipe to the list of suggestions. Once we have 5 such recipes, we return the list of suggestions.


## Challenges
#### Design
As designers, going into this project we both lacked previous industry experience working with cross-functional teams. This proved to be challenging in terms of syncing up the progress timelines between designers and developers - in retrospect, we learned that it would be helpful to create a working timeline that shows the progress of both the developers and designers, so that every team member could keep track of one another’s progress.
#### Front-end
One of our main challenges was integrating the frontend with the backend. As the number of services our app relied on grew, the many asynchronous API calls complicated the program flow. We grew a lot as front-end developers and were able to put into practice more advanced aspects of Swift, such as protocols and delegates, property observers, and creating completion handlers to capture data using closures.
#### Back-end
The largest issue that consistently blocked our ideas from being developed further was sourcing data. It was difficult to find APIs that fit our needs exactly or that allowed free usage. We were not able to find a good source of ingredient data with expiration times, or a good recipe database that could integrate well with our ingredients.

## Designs
Low-fi sketches
![low-fi Sketches](/photos/lofi-sketches.png "low-fi sketches")

Mid-fi wireframes

![mid-fi wireframes](/photos/launchpad-midfimockups.jpg "mid-fi wireframes")

Hi-fi wireframes

![hi-fi wireframes](/photos/hifi-mockups.png "hi-fi wireframes")

UI Library

![UI Library](/photos/uilibrary.png "UI Library")

## Finished product
Click on the link to watch our demo video:
**[Keepfresh Demo](https://www.youtube.com/watch?time_continue=1&v=TWh32lj3Yjs&feature=emb_title)**

## Future Steps
- Allow users to create a shopping list
- Allow users to add recipe items that they are missing directly from the recipe page to their shopping list
- Users may scan their grocery shopping receipt barcode to add those items to their pantry
- Allow users to filter recipes based on cuisine type, time, difficulty, etc.
