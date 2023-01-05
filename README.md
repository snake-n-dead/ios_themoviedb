# README #

Movies project - application, which is showing 100 most popular movies from https://www.themoviedb.org/. Here is 2-pages application written on Swift without using any other libraries for compiling. 

### Architecture: VIPER ###

I'm using custom modified VIPER architecture, where we have modules with the layers inside + network service, which is wrapped into cross-module interactor system& I'm trying to use Clean Architecture approaches with Protocol-oriented way of programming, according to good layer of abstraction. It helps a lot in the task splitting between layers and checking PR with a simple and strict rules

## Templates

My implementation of VIPER need to have at least one protocol for all of the layers, and it require a lot of boilerplate code, so I created templates for all of the possible module states + for fast Interactor creating. I used [Generamba tool](https://github.com/strongself/Generamba) for it, and all of my templates is inside of Xcode projects. You don't need to install Generamba for compiling project, except the case you want to try my templates ;)

> **Module**
>
> All of the internal classes, divided in layers, that we need to have for existing UIViewController.

### Inner module layers:
* View - View controller as a passive view, can only get primitive data and show it for UI. Main responsibility it's to draw right ui, and the secondary - catch user actions like taps & scrolls - and notify presenter about it
* Presenter - Class, which is handling actions from view and have a right of decision - where we need to take data + how we can manage with actions around it
* Router - It's an object, which is working directly with navigation for our View and managing routing between modules with data transferring with it
* Builder - Layer, which is helping to build a module with all of the required data in a right order, for being ready to present all the required data.
* CollectionMediator - Layer, which is helping to manage a collections, by splitting up responsibilities from View and Presenter and allowing them to manage simple collections.

### Cross module layers:

* Interactors - layer, that unites all of the interactors together.
* Network manager - service, that we need for managing network requests and responses, including parsing and all the functions that we nned for working with REST transport 
* Image service - service, that allows us to work with image downloading, cache and cancelling requests, when image is disappearing from screen, for improving network usage

## Interactors

My main difference in common VIPER implementation - is to make Interactors as an objects, which is living separately from each other and allocated for each module separately, according to rule: 1 request - 1 interactors. Each interactor as a single class provide us request and response for a single data path in network.

### What to improve:

* I didn't including a good way for managing router between different user scenarios *(like tutorial and loggen in state)* which is calles AppCoordinator, so right now it's simplified for managing simple routes only without managing different storyboards
* Cache system or any type of storage is not implemented too, so it can be easily extended in Interactor layers =)
* Collection mediator could be implemented as cross-module generic class, but it require more time for creating it smooth and according to all best principes 
