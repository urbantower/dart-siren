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
part of siren;

/**
 * This mixin supports the access to DOM elements via $(ID).
 * It's better querySelector based on IDs with cache support. 
 */
abstract class DomManipulationMixin {
  
  Map<String, HtmlElement> _elements = new Map();
  
  /**
   * get the element by ID.
   */
  HtmlElement $(String id) {    
    HtmlElement element = _elements[id];
    if (element == null) { 
      element =  (this as HtmlElement).querySelector("#${id}");
      if (element != null) {
        _elements[id] = element;
      }
    }    
    return element;
  }  
}


/**
 * this mixin adds the event subscription functionality based on 
 * annotations to your component 'SubscribeEvent' 
 */
abstract class EventSubscriberMixin {
    
  /**
   * main subscribtion method
   */
  subscribeEvents() {
    var subsrciptors = _findSubsriptors(this);
    for (EventSubscriptor subscriptor in subsrciptors) {
      subscriptor.subscribe();
    }
  }
  
  /**
   * method scan the instance and returns subscriptor
   */
  List<EventSubscriptor> _findSubsriptors(Object obj) {
    var instanceMirror = reflect(obj);
    List<EventSubscriptor> subscriptors = new List();
    for(MethodMirror method in instanceMirror.type.instanceMembers.values) {
      for (var m in method.metadata) {
        if (m.reflectee is Listener) {
          subscriptors.add(new EventSubscriptor((this as HtmlElement), instanceMirror, method.simpleName, m.reflectee));
        }
      }
    }
    return subscriptors;
  }
}