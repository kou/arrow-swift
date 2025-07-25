// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import PackageDescription

let package = Package(
    name: "Arrow",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "Arrow",
            targets: ["Arrow"])
    ],
    dependencies: [
        .package(url: "https://github.com/google/flatbuffers.git", from: "25.2.10"),
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.3.0")
    ],
    targets: [
        .target(
            name: "ArrowC",
            path: "Sources/ArrowC",
            swiftSettings: [
                // build: .unsafeFlags(["-warnings-as-errors"])
            ]

        ),
        .target(
            name: "Arrow",
            dependencies: ["ArrowC",
                           .product(name: "FlatBuffers", package: "flatbuffers"),
                           .product(name: "Atomics", package: "swift-atomics")
            ],
            swiftSettings: [
                // build: .unsafeFlags(["-warnings-as-errors"])
            ]
        ),
        .testTarget(
            name: "ArrowTests",
            dependencies: ["Arrow", "ArrowC"],
            swiftSettings: [
                // build: .unsafeFlags(["-warnings-as-errors"])
            ]
        )
    ]
)
