import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 650, // Aumenta la altura según sea necesario
      padding:  const EdgeInsets.fromLTRB(0, 20, 0, 0),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
              Stack(
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaY: 0.5, sigmaX: 0.5),
                    child: Container(
                    width: double.infinity,
                      height: 400, // Ajusta la altura según sea necesario
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), // Efecto de opacidad
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 20,
                    bottom: 20,
                    child: FadeInText(
                      text: 'LABORATORIO UCB',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            Expanded(
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      fit:  FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SocialMediaIcon(
                            icon: Icons.facebook,
                            label: 'Facebook',
                            url: 'https://www.facebook.com/UCB.BOLIVIA/',
                          ),
                          SocialMediaIcon(
                            icon: Icons.camera,
                            label: 'Instagram',
                            url: 'https://www.instagram.com/ucb.lapaz/?hl=en',
                          ),
                          SocialMediaIcon(
                            icon: Icons.alternate_email,
                            label: 'Twitter',
                            url: 'https://x.com/UCBLaPaz/',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      flex: 1,
                      fit:  FlexFit.tight,
                      child: SocialMediaIcon(
                        icon: Icons.map,
                        label: "Ubicación",
                        url: 'https://maps.app.goo.gl/gnNShhurjLcXhvCi8',
                      ),
                    ),
                    SizedBox(width: 20),

                    const Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: FadeInText(
                        text:
                            'En el Laboratorio de la Universidad Catolica Boliviana, estamos comprometidos con la excelencia academica y la investigacion. Nuestro Laboratorio ofrece una gama de materiales y recursos para apoyar el desarrollo de proyectos cientificos y academicos. En el Laboratorio de la Universidad Catolica',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SocialMediaIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const SocialMediaIcon({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  _SocialMediaIconState createState() => _SocialMediaIconState();
}

class _SocialMediaIconState extends State<SocialMediaIcon>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.blue,
    ).animate(_controller);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _controller.forward();
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        _controller.reverse();
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () => _launchURL(widget.url),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child:
                    Icon(widget.icon, color: _colorAnimation.value, size: 30),
              ),
              SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color: _colorAnimation.value,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class FadeInText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const FadeInText({
    required this.text,
    required this.style,
  });

  @override
  _FadeInTextState createState() => _FadeInTextState();
}

class _FadeInTextState extends State<FadeInText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Text(
        widget.text,
        style: widget.style,
      ),
    );
  }
}
