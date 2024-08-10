import 'package:app/Events/colors.dart';
import 'package:app/Events/event_card.dart';
import 'package:flutter/material.dart';

class GridViewEventsBuilder extends StatelessWidget {
  const GridViewEventsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4),
      child: GridView.builder(
        itemCount: 36,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {

          if ((index + 1) % 5 == 0) {
            return const EventCard(
              eventName: "Robosoccer",
              imgURL: "assets/images/sh1.png",
              colorUp: card1up,
              colorDown: card1down,
              colorMinor: card1minor,
            );
          } else if ((index + 1) % 4 == 0) {
            return const EventCard(
              eventName: "Dronetrix",
              imgURL: "assets/images/sh4.png",
              colorUp: card4up,
              colorDown: card4down,
              colorMinor: card4minor,
            );
          } else if ((index + 1) % 3 == 0) {
            return const EventCard(
              eventName: 'RC Rallycross',
              imgURL: "assets/images/sh3.png",
              colorUp: card3up,
              colorDown: card3down,
              colorMinor: card3minor,
            );
          } else if ((index + 1) % 2 == 0) {
            return const EventCard(
              eventName: 'RC Plane',
              imgURL: 'assets/images/sh2.png',
              colorUp: card2up,
              colorDown: card2down,
              colorMinor: card2minor,
            );
          } else {
            return const EventCard(
              eventName: "Robosoccer",
              imgURL: "assets/images/sh1.png",
              colorUp: card5up,
              colorDown: card5down,
              colorMinor: card5minor,
            );
          }
        },
      ),
    );
  }
}
