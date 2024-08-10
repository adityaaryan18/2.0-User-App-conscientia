import 'package:app/Events/colors.dart';
import 'package:app/Events/workshop_card.dart';
import 'package:flutter/material.dart';

class ListViewWorkshopBuilder extends StatelessWidget {
  const ListViewWorkshopBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        const eventName = "Night Sky Hunt";
        const imgURL = "assets/images/shoe1.png";
        if ((index + 1) % 5 == 0) {
          return const WorkshopCard(
            aboutWorkshop:
                "A maze solver event is a competition or activity where participants are tasked with navigating or programming a solution to traverse a maze from a starting point to an end point. These events can take various forms, from physical mazes to virtual or algorithmic challenges.",
            eventName: eventName,
            imgURL: imgURL,
            colorUp: card5up,
            colorDown: card5down,
            colorMinor: card5minor,
          );
        } else if ((index + 1) % 4 == 0) {
          return const WorkshopCard(
            aboutWorkshop:
                "A maze solver event is a competition or activity where participants are tasked with navigating or programming a solution to traverse a maze from a starting point to an end point. These events can take various forms, from physical mazes to virtual or algorithmic challenges.",
            eventName: eventName,
            imgURL: imgURL,
            colorUp: card4up,
            colorDown: card4down,
            colorMinor: card4minor,
          );
        } else if ((index + 1) % 3 == 0) {
          return const WorkshopCard(
            aboutWorkshop:
                "A maze solver event is a competition or activity where participants are tasked with navigating or programming a solution to traverse a maze from a starting point to an end point. These events can take various forms, from physical mazes to virtual or algorithmic challenges.",
            eventName: eventName,
            imgURL: imgURL,
            colorUp: card3up,
            colorDown: card3down,
            colorMinor: card3minor,
          );
        } else if ((index + 1) % 2 == 0) {
          return const WorkshopCard(
            aboutWorkshop:
                "A maze solver event is a competition or activity where participants are tasked with navigating or programming a solution to traverse a maze from a starting point to an end point. These events can take various forms, from physical mazes to virtual or algorithmic challenges.",
            eventName: eventName,
            imgURL: imgURL,
            colorUp: card2up,
            colorDown: card2down,
            colorMinor: card2minor,
          );
        } else {
          return const WorkshopCard(
            aboutWorkshop:
                "A maze solver event is a competition or activity where participants are tasked with navigating or programming a solution to traverse a maze from a starting point to an end point. These events can take various forms, from physical mazes to virtual or algorithmic challenges.",
            eventName: eventName,
            imgURL: imgURL,
            colorUp: card1up,
            colorDown: card1down,
            colorMinor: card1minor,
          );
        }
      },
    );
  }
}