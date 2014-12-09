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
 * subscriptor represents link between method and event 
 */
class EventSubscriptor {
  final InstanceMirror      instanceMirror;
  final Symbol              method;
  final Listener            metadata; 
  final HtmlElement         source;
  
  /**
   * Constructor
   */
  EventSubscriptor(this.source, this.instanceMirror, this.method, this.metadata);
  
  /**
   * subscribe method to event you choose
   */
  subscribe() {
    HtmlElement target = null;
    if (metadata.id.isNotEmpty) {
      target = source.querySelector("#${metadata.id}");
    } else {
      target = source;
    }
    if (target != null) {
      target.addEventListener(metadata.name, (event) {
        instanceMirror.invoke(method, [event]);       
      });
    }
  }
}
