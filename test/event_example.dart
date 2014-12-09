// Copyright 2014 Zdenko Vrabel. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
library event_example;

import 'package:siren/siren.dart';
import 'dart:html';

/**
 * Simple component impl.
 */
@WebComponent("custom-formular", template: "formular-template")
class FooComponent extends SirenTemplateComponent {
  
  InputElement get nameField => $("name-field");
  HtmlElement  get output => $("output");

  /// constructor
  FooComponent.created() : super.created();
  
  @override
  void ready() {
    //do nothing
  }
    
  /// handler for on-change event on 'name-field'
  @Listener(EventType.ON_CHANGE, id: "name-field")
  onNameChanged(Event e) {
    print("changing to ${nameField.value}");
    _checkTheName();
  }
    
  /// on-click handler for button
  @Listener(EventType.ON_CLICK, id: "button")
  onButtonClick(Event e) {
    print("Clicked to button!");
    _checkTheName();
  }
    
  /// handler for 'customevent'
  @Listener("customevent")
  onCustomEvent(Event e) {
    output.text = "The length is more than 10";
  }
    
  /// check the length of name and fire custom event
  void _checkTheName() {
    if (nameField.value.length > 10) {
      fire("customevent");
    }    
  }
}


/**
 * Main method
 */
void main() {
  initSiren();
}