Madame, Monsieur les membres du jury,

Actuellement Ingénieur de Recherche (BIATSS) à l’Université de Montpellier et affecté au département de robotique du LIRMM, je candidate au poste d’Ingénieur de Recherche titulaire au CNRS (Concours Externe n°31 / BAP C). Fort de douze années d’expérience acquises au sein de laboratoires d'excellence en France et à l’international, je souhaite mettre mon expertise en robotique humanoïde, en vision par ordinateur et en développement logiciel au service direct de l'innovation scientifique.

Mon parcours repose sur une double compétence : la maîtrise approfondie du développement logiciel (notamment C++, Python, ROS) et une expertise de terrain dans la mise en œuvre d'expérimentations complexes. J’ai déployé des robots humanoïdes lors de démonstrations internationales exigeantes, garantissant leur fiabilité opérationnelle en environnements contraints. Mon objectif au LIRMM est de pérenniser le patrimoine logiciel du laboratoire, maintenir son parc robotique hétérogène, structurer l’environnement expérimental et former les chercheurs aux meilleures pratiques de l’ingénierie.

1. Une vocation ancrée dans l'ingénierie logicielle
Ma vocation est née d'une curiosité précoce pour l'informatique. Dès l'école primaire, la découverte d'un ancien Macintosh a éveillé en moi le besoin de comprendre l'architecture interne des machines et l'exécution des systèmes. 

Au collège, j'ai appris le C++ en autodidacte via les tutoriels du « Site du Zéro ». Les limites matérielles de ma machine de l'époque (256 Mo de RAM, 4 Go de disque dur) m'ont rapidement mené vers l'écosystème Linux (Ubuntu 8.04). Résoudre des problèmes d'installation de composants réseau m'a fait découvrir l'univers de la ligne de commande (Bash), la compilation de pilotes pour le noyau Linux et le contrôle profond qu'offre l'open-source. Après avoir exploré la programmation web (PHP/HTML/CSS), Python et le développement 2D avec la bibliothèque SFML, j'ai co-développé au lycée le logiciel de manipulation d'images *Fotowall*. 

Hébergé sur GitHub dès les débuts de la plateforme et co-conçu avec Enrico Ros (développeur C++ expérimenté), ce projet — toujours maintenu — a dépassé le million de téléchargements en 2017. Il m'a appris les principes du développement collaboratif (Git), l'API C++ Qt et les défis de maintenance à long terme. Ce socle technique m'a permis d'aborder mes études à Polytech Nice Sophia puis mes travaux de recherche avec une agilité logicielle déjà confirmée.

2. Une expertise éprouvée par les grands défis internationaux
Mon expérience s’est forgée sur des projets mondiaux, m’habituant à gérer des systèmes complexes sous forte pression opérationnelle.

En doctorat, j’ai intégré l’équipe franco-japonaise AIST-NEDO pour le DARPA Robotics Challenge (DRC), fruit d'une collaboration entre le JRL et le groupe HRG de l’AIST. Confronté à la réalité du terrain (faire conduire une voiture et franchir des obstacles à un humanoïde), j’y ai développé des modules de traitement 3D (ICP, recalage de nuages de points) et compris qu'un code isolé ne suffit pas si l’intégration système globale manque de robustesse. J'ai prolongé cette dynamique sur le projet européen H2020 COMANOID, comme responsable de la chaîne de localisation SLAM pour le démonstrateur final chez Airbus à Saint-Nazaire. Pour le défi de la montée d’escaliers, exigeant une précision centimétrique pour éviter les collisions, j'ai assuré l’intégration complète entre la localisation et le planificateur de marche développé par S. Caron au LIRMM.

Pour la compétition ANA Avatar XPrize au sein de l’équipe Janus, j’ai conçu l'intégralité du démonstrateur des phases de sélection : une téléopération en VR du robot HRP-4J. J'ai développé l'architecture couplant ROS et Unity 3D pour le retour vidéo (caméra Intel RealSense) et la transmission des commandes (trackers Vive, joystick). Côté robot, un contrôleur temps-réel en C++ gérait la réception des données, la génération de trajectoire de marche (MPC), le suivi corps complet (QP) et l'interaction sécurisée en force (hand-over d'objets). 

Ce socle a servi pour les demi-finales au LIRMM, où j'ai intégré les travaux de thèse d'A. Dallard (détection des mouvements de marche, contraintes en force) et un nouveau préhenseur. Lors des finales aux États-Unis, après avoir ajouté des capteurs tactiles Bluetooth et un bouton de sécurité sans fil, j'ai fait preuve d'une réactivité décisive en migrant au côté de P. Gergondet l'architecture complète, en moins de 24 heures, vers le contrôleur de marche de S. Caron pour pallier une défaillance technique, tout en y adaptant le planificateur de pas d'A. Dallard.

En autonomie, j’ai également assuré seul la mise en œuvre technique d’une performance de danse humanoïde au Centre des Arts d’Enghien-les-Bains, intégrant les travaux de thèse d'H. Hong (trackers Xsens, détection de mouvements) et le logiciel de scène TouchDesigner via le protocole MQTT, lors de deux semaines de co-construction avec les artistes.

Au JRL (Japon), j'ai piloté une transition technologique majeure : l'abandon du framework historique HMC au profit de mc_rtc, initié par P. Gergondet. Validé par la direction, ce choix a rationalisé les développements et facilité l'accueil des étudiants grâce à une documentation rigoureuse. Cette transition a propulsé mc_rtc, qui supporte aujourd'hui des dizaines de robots (humanoïdes, bras, quadrupèdes) dans des laboratoires internationaux (JRL, LIRMM, EPFL, TUM) et sert de pilier à des projets d'envergure (H2020 I.AM) et des collaborations industrielles (loco-manipulation de bobines, déchargement de pneus avec Michelin).

3. Adéquation avec les besoins du LIRMM : maintenance et intégration
Ma candidature s'inscrit en cohérence directe avec les besoins du département de robotique du LIRMM. Mon poste actuel de BIATSS m'a permis de prendre la responsabilité logicielle et matérielle de plateformes clés : les humanoïdes HRP-4, RHPS1, Unitree G1, et les bras Franka Emika Panda ou Universal Robots. Mon action s'articule autour de quatre axes :

*   **Maintenance matérielle et logicielle :** J'interviens sur le hardware (re-taraudage, soudures, réparations sur HRP-4) pour prolonger leur cycle de vie, tout en modernisant les couches logicielles via Docker/Devcontainers et Nix pour garantir une reproductibilité absolue.
*   **Maîtrise technologique et diffusion :** Je maîtrise toute la chaîne de contrôle-commande (perception, SLAM, QP corps complet) et l'écosystème associé (mc_rtc, ROS, Python). Je m'implique dans la diffusion des compétences (workshop Humanoids 2022 avec P. Gergondet, présentation mc_rtc/ROS à la ROSCon 2025).
*   **Conception et fabrication :** Ma maîtrise de la CAO et de l'impression 3D me permet de concevoir rapidement les supports de capteurs et pièces d'interface nécessaires aux expérimentations.
*   **Support et formation :** J'accompagne les doctorants pour fiabiliser leurs démonstrateurs et assurer le transfert de compétences (ex. valorisation des travaux d'H. Lefèvre pour l’évaluation HCERES).

Mon expertise est transverse aux besoins des différentes équipes du département :
*   **DEXTER (robotique médicale) :** Leurs problématiques de téléopération partagent de fortes analogies avec mon expérience XPrize. J'échange avec Lucas Lavenir et Robin Passama pour interconnecter leurs pilotes et démonstrateurs avec mc_rtc, répondant à leur besoin de structuration face à la complexité des expérimentations.
*   **RSM (robotique sous-marine) :** Bien que le milieu diffère, les défis expérimentaux y sont similaires : robustesse logicielle, intégration de capteurs (sonars, où mon bagage en vision est un atout) et sécurisation des essais.
*   **ICAR (vision et robotique) :** Mes travaux en SLAM avec Andrew Comport, combinés à mes compétences en ingénierie logicielle et calcul GPU (framework Caffe au TUM), s'alignent directement sur leurs verrous scientifiques.
*   **IDH (interaction homme-robot) :** Mon équipe d'ancrage historique, de laquelle mon parcours est indissociable.

4. Vision d'avenir et engagement pour la communauté
Mon projet au CNRS est de bâtir un socle technique commun pour la robotique française afin d'éviter la duplication des efforts entre laboratoires. La science ouverte doit s'appuyer sur une infrastructure logicielle pérenne garantissant la reproductibilité stricte des publications.

J'ai initié plusieurs chantiers dans cette direction :
*   L'interconnexion active entre mc_rtc et les outils développés au LIRMM (framework *robocop* et méthodologie de packaging PID).
*   Des discussions avec le LAAS-CNRS pour faciliter la transition de leur framework *Stack-of-Tasks* vers mc_rtc afin de mutualiser l'effort national. J’ai aussi co-conçu avec G. Saurel une architecture basée sur Nix pour la reproductibilité et l'amélioratoin de l'expérience utilisateur, co-présentée avec succès aux Tech Days 2RM 2026.

En intégrant le CNRS en tant qu'ingénieur de recherche titulaire, je souhaite mettre mon expertise au service du LIRMM pour offrir aux chercheurs le meilleur cadre technique possible. Mon ambition est de participer activement aux dynamiques nationales de rationalisation, de déploiement et de transfert industriel des logiciels de robotique.

Je vous prie d’agréer, Madame, Monsieur les membres du jury, l’expression de ma considération distinguée.
