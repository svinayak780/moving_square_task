//
//  main.dart
//
//  Created by Vinayak Sharma on 18/02/25.
//

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Padding(padding: EdgeInsets.all(32.0), child: SquareAnimation()),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation>
    with TickerProviderStateMixin {

  /// Constant size of the square
  static const _squareSize = 50.0;
  /// Position of the square from left edge
  double position = 0.0;
  /// Booleans to enable/disable the left button
  bool leftEnabled = true;
  /// Booleans to enable/disable the right button
  bool rightEnabled = true;
  /// Duration of the animation
  static const Duration _duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    /// [LayoutBuilder] to get the constraints of the parent widget
    return LayoutBuilder(
      builder: (context, constraints) {
        /// Calculate the initial position of the square
        position = (constraints.maxWidth - _squareSize) / 2;
        /// [StatefulBuilder] to manage an independent state
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                /// <Left side> <Square> <Right side>
                /// Left side animates to move all elements
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// [AnimatedContainer] to animate the square implicitly
                    AnimatedContainer(
                      duration: _duration,
                      width: position,
                      // Left side of the square
                      // Can be used to display widgets
                    ),
                    Container(
                      width: _squareSize,
                      height: _squareSize,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        // Right side of the square
                        // Can be used to display widgets
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed:
                          /// Enable the button only if [rightEnabled] is true
                          rightEnabled
                              ? () {
                                setState(() {
                                  /// Disable the button during animation
                                  rightEnabled = false;
                                  /// Check if next movement will exceed the right edge
                                  if (position + _squareSize >
                                      constraints.maxWidth - _squareSize) {
                                    /// Set the position to the right edge
                                    position =
                                        constraints.maxWidth - _squareSize;
                                  } else {
                                    /// Move the square to the right
                                    position += _squareSize;
                                    /// Enable the buttons after the animation
                                    Future.delayed(
                                      _duration,
                                      () {
                                        setState(() {
                                          /// Enable the left button if the square is not at the left edge
                                          if (position != 0) {
                                            leftEnabled = true;
                                          }
                                          /// Enable the right button if the square is not at the right edge
                                          if (position !=
                                              constraints.maxWidth -
                                                  _squareSize) {
                                            rightEnabled = true;
                                          }
                                        });
                                      },
                                    );
                                  }
                                });
                              }
                              : null,
                      child: const Text('Right'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed:
                          /// Enable the button only if [leftEnabled] is true
                          leftEnabled
                              ? () {
                                setState(() {
                                  /// Disable the button during animation
                                  leftEnabled = false;
                                  /// Check if next movement will exceed the left edge
                                  if (position - _squareSize < 0) {
                                    /// Set the position to the left edge
                                    position = 0;
                                  } else {
                                    /// Move the square to the left
                                    position -= _squareSize;
                                    /// Enable the buttons after the animation
                                    Future.delayed(
                                      _duration,
                                      () {
                                        setState(() {
                                          /// Enable the left button if the square is not at the left edge
                                          if (position != 0) {
                                            leftEnabled = true;
                                          }
                                          /// Enable the right button if the square is not at the right edge
                                          if (position !=
                                              constraints.maxWidth -
                                                  _squareSize) {
                                            rightEnabled = true;
                                          }
                                        });
                                      },
                                    );
                                  }
                                });
                              }
                              : null,
                      child: const Text('Left'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
