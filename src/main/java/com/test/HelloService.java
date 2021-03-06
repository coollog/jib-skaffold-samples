/*
 * Copyright 2018 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package com.test;

import static spark.Spark.get;
import static spark.Spark.port;
import static spark.Spark.staticFiles;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import dependency.Greeting;

public class HelloService {

  public static void main(String[] args) {
    port(8080);
    staticFiles.location("/public");
    get(
        "/hello",
        (req, res) -> {
          System.out.println("Got /hello");
          HttpResponse<String> name = Unirest.get("http://name-service/name").asString();
          return Greeting.getGreeting() + " " + name.getBody();
        });

    get("/leeroy",
        (req, res) -> {
          System.out.println("Got /leeroy");
          return Unirest.get("http://leeroy-app").asString().getBody();
        });
  }
}
