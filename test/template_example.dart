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
library template_example;

import 'package:siren/siren.dart';


/**
 * Simple foo component impl.
 */
@WebComponent("foo-component")
class FooComponent extends SirenComponent {
  
  FooComponent.created() : super.created();
  
  @override
  void ready() {
    this.appendHtml("<h3>Foo component</h3>");
  }
}



/**
 * bar template component impl. The 'dependsOn' is a list of all 
 * component dependencies they're used inside the component.
 */
@WebComponent("bar-component", template: "bar-template", dependsOn: const[ FooComponent ])
class BarComponent extends SirenTemplateComponent {
  
  FooComponent get foo => $("foo-id");
  
  BarComponent.created() : super.created();

  @override
  ready() {
    foo.title = "This FOO is inside BAR";
  }
}


/**
 * Main method
 */
void main() {
  initSiren();
}