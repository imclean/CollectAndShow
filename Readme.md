# Collect And Show: Rx-MVVM-C

A very simple app with RxSwift and the MVVM-C architecture that collects Sources and Articles from an online source with a refresh control.

This project has little or no Unit Tests as is an example of Rx working in an MVVM-C Architecture and is not meant to be an example of Unit Testing.

The webservice is also an example of using a Reactive Compatible class and a direct observable returned from a function.

The pull to refresh of the sources controller utilises an observable public var within the viewmodel which is internally observed within the viewModel itself.

This is not an exercise in design or layout and simple table cells are used to display the data, however constraints are applied to allow dynamic cell heights.

There are no custom errors within the app.