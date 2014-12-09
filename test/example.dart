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
import 'package:siren/siren.dart';
import 'package:logging/logging.dart';
import 'dart:html';
import 'dart:async';

@WebComponent("custom-template", template: "custom-template", dependsOn: const[ FooElement ])
class CustomTemplateElement extends TemplateComponent {
  
  CustomTemplateElement.created() : super.created();
  
  FooElement get customFoo => $("custom"); 
  
  
  @override
  void ready() {
    print("custom-template is ready");
  }
  
  
  @Listener(EventType.ON_CLICK, id: "custom")
  void onClickCustom(Event e) {
    print("clicked ${customFoo.testAttr}");    
  }
  
  @Listener(EventType.ON_KEYPRESS, id: "text-field")
  void onClickTextField(Event e) {
    print("key press");
  }
  
}


@WebComponent("custom-foo", initMethod: "init")
class FooElement extends HtmlElement {
  String testAttr = "test";
  
  /**
   * constructor
   */
  FooElement.created() : super.created() {
  }
  
  @override
  void attached() {
    print("attached custom-foo");
    this.appendHtml("<div>web component FOO</div>");
  }
  
  static void init() {
    print("registration of custom-foo");
  }
}


void main() {
  try {
    //enable logging
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
    
    //initialize siren
    initSiren();
   
    var timeout = new Duration(seconds: 1);
    new Timer(timeout, (){
      var x = (document.body.querySelector("#custom") as FooElement);
      print("${x.testAttr}");      
    });
    
  } catch (e) {
    print("${e}");
  }
  
}