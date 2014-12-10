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
library siren;

import 'dart:html';
import 'dart:mirrors';
import 'package:logging/logging.dart';

part 'src/annotations.dart';
part 'src/engine.dart';
part 'src/mixins.dart';
part 'src/events.dart';
part 'src/template.dart';
part 'src/components.dart';


/**
 * initialize siren framework, register all annotated classes 
 * as custom elements
 */
initSiren({SirenApp app, Iterable<String> excludedLibraries, Iterable<String> excludedClasses}) {
  
  if (app != null) {
    app.init();
  }

  _siren = new SirenEngine();  
  
  if (excludedLibraries != null) {
    _siren.excludedLibraries.addAll(excludedLibraries);
  }    
  if (excludedClasses != null) {
    _siren.excludedClasses.addAll(excludedClasses);
  }
  
  _siren.scan();
  
  if (app != null) {
    app.ready();
  }
}

SirenEngine _siren; 
SirenEngine get siren => _siren;