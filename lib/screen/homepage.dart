import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25,left: 20),
                child: Text("Pinned Notes",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 10),
                child: SizedBox(
                  height: 350,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 4,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 260,
                        child: _IdeaCard(),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25,left: 20),
                child: Text("Interesting Idea",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 10),
                child: SizedBox(
                  height: 290,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 4,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 260,
                        child: ProductIdeaCard(),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        )
      ),
    );
  }
}


class _IdeaCard extends StatelessWidget {
  const _IdeaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '💡 New Product\nIdea Design',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B6B6B),
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Material(
            color: const Color(0xFFC73A4D),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Center(
                  child: Text(
                    'Interesting Idea',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class ProductIdeaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6CC), // soft yellow
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "💡 New Product\nIdea Design",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Create a mobile app UI kit that provides basic notes functionality but with some improvement.",
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "There will be a choice to select what kind of notes that user needs, so the experience while taking notes can be unique based on the needs.",
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
