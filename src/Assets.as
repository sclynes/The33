package  
{
	 import net.flashpunk.graphics.TiledSpritemap
	public class Assets 
	{
		[Embed(source="../assets/graphics/tilesetspaceship.png")] public static const SOLID_TILESET:Class;
		[Embed(source = "../assets/graphics/backdrops/01.png")] public static const BD_01:Class;

		[Embed(source = "../assets/graphics/bomb.png")] public static const BOMB:Class;
		[Embed(source = "../assets/graphics/title.png")] public static const TITLE:Class;
		[Embed(source = "../assets/graphics/laser.png")] public static const LASER:Class;
		[Embed(source = "../assets/graphics/coin.png")] public static const COIN:Class;
		[Embed(source = "../assets/graphics/bonusbrick.png")] public static const BONUS_BRICK:Class;
		[Embed(source = "../assets/graphics/bonus.png")] public static const BONUS_TEXT:Class;
		[Embed(source = "../assets/graphics/noiseyStep.png")] public static const NOISEY_STEP:Class;
		
		[Embed(source = "../assets/graphics/pelter.png")] public static const PELTER:Class;
		[Embed(source = "../assets/graphics/player/player_complete_ps.png")] public static const PLAYER:Class;
		[Embed(source = "../assets/graphics/player/player_ghost.png")] public static const PLAYER_GHOST:Class;
		
		[Embed(source = "../assets/graphics/backdrops/bbc.png")] public static const BBC:Class;
		[Embed(source = "../assets/graphics/props/computer.png")] public static const COMPUTER:Class;
		
		[Embed(source = "../assets/sfx/coin2.sfs",mimeType = "application/octet-stream")] public static const SFX_COIN:Class;
		[Embed(source = "../assets/sfx/coin_success2.sfs", mimeType = "application/octet-stream")] public static const SFX_COIN_SUCCESS:Class;
		[Embed(source = "../assets/sfx/gravity_switch.sfs", mimeType = "application/octet-stream")] public static const SFX_GRAVITY_SWITCH:Class;
		[Embed(source = "../assets/sfx/jump.sfs", mimeType = "application/octet-stream")] public static const SFX_JUMP:Class;
		[Embed(source = "../assets/sfx/stomp.sfs", mimeType = "application/octet-stream")] public static const SFX_STOMP:Class;
		[Embed(source = "../assets/sfx/ready.sfs", mimeType = "application/octet-stream")] public static const SFX_READY:Class;
		[Embed(source = "../assets/sfx/bomb.sfs", mimeType = "application/octet-stream")] public static const SFX_BOMB:Class;
		[Embed(source = "../assets/sfx/pelter.sfs", mimeType = "application/octet-stream")] public static const SFX_PELTER:Class;
		[Embed(source = "../assets/sfx/laser.sfs", mimeType = "application/octet-stream")] public static const SFX_LASER:Class;
		[Embed(source = "../assets/sfx/laser_death.sfs", mimeType = "application/octet-stream")] public static const SFX_LASER_DEATH:Class;
		[Embed(source = "../assets/sfx/typing.sfs", mimeType = "application/octet-stream")] public static const SFX_TYPING:Class;
		[Embed(source = "../assets/sfx/select0.sfs", mimeType = "application/octet-stream")] public static const SFX_LEVEL_SELECT:Class;
		[Embed(source = "../assets/sfx/stomp.mp3")] public static const SFX_STOMP_MP3:Class;
		
		[Embed(source = "../assets/fonts/Orbitron Black.ttf",embedAsCFF = "false", fontFamily = 'MainFont')] public static const FONT:Class;
		
		[Embed(source = "../assets/sfx/music/cakephone.mp3")] public static const MUSIC_CAKEPHONE:Class;
		
		[Embed(source = "../assets/levels/nodes.xml", mimeType = "application/octet-stream")] public static const LEVEL_NODES:Class;
		
		[Embed(source = "../assets/levels/level00.tmx", mimeType = "application/octet-stream")] public static const LEVEL_00:Class;
		[Embed(source = "../assets/levels/level01.tmx", mimeType = "application/octet-stream")] public static const LEVEL_01:Class;
		[Embed(source = "../assets/levels/level02.tmx", mimeType = "application/octet-stream")] public static const LEVEL_02:Class;
		[Embed(source = "../assets/levels/level03.tmx", mimeType = "application/octet-stream")] public static const LEVEL_03:Class;
		[Embed(source = "../assets/levels/level04.tmx", mimeType = "application/octet-stream")] public static const LEVEL_04:Class;
		[Embed(source = "../assets/levels/level05.tmx", mimeType = "application/octet-stream")] public static const LEVEL_05:Class;
		[Embed(source = "../assets/levels/level06.tmx", mimeType = "application/octet-stream")] public static const LEVEL_06:Class;
		[Embed(source = "../assets/levels/level07.tmx", mimeType = "application/octet-stream")] public static const LEVEL_07:Class;
		[Embed(source = "../assets/levels/level08.tmx", mimeType = "application/octet-stream")] public static const LEVEL_08:Class;
		[Embed(source = "../assets/levels/level09.tmx", mimeType = "application/octet-stream")] public static const LEVEL_09:Class;
		[Embed(source = "../assets/levels/level10.tmx", mimeType = "application/octet-stream")] public static const LEVEL_10:Class;
		[Embed(source = "../assets/levels/level11.tmx", mimeType = "application/octet-stream")] public static const LEVEL_11:Class;
		[Embed(source = "../assets/levels/level12.tmx", mimeType = "application/octet-stream")] public static const LEVEL_12:Class;
		[Embed(source = "../assets/levels/level13.tmx", mimeType = "application/octet-stream")] public static const LEVEL_13:Class;
		[Embed(source = "../assets/levels/level14.tmx", mimeType = "application/octet-stream")] public static const LEVEL_14:Class;
		[Embed(source = "../assets/levels/level15.tmx", mimeType = "application/octet-stream")] public static const LEVEL_15:Class;
		[Embed(source = "../assets/levels/level16.tmx", mimeType = "application/octet-stream")] public static const LEVEL_16:Class;
		[Embed(source = "../assets/levels/level17.tmx", mimeType = "application/octet-stream")] public static const LEVEL_17:Class;
		[Embed(source = "../assets/levels/level18.tmx", mimeType = "application/octet-stream")] public static const LEVEL_18:Class;
		[Embed(source = "../assets/levels/level19.tmx", mimeType = "application/octet-stream")] public static const LEVEL_19:Class;
		[Embed(source = "../assets/levels/level20.tmx", mimeType = "application/octet-stream")] public static const LEVEL_20:Class;

		
		[Embed(source = "../assets/levels/meta/level00.xml", mimeType = "application/octet-stream")] public static const LEVEL_00_META:Class;
		[Embed(source = "../assets/levels/meta/level01.xml", mimeType = "application/octet-stream")] public static const LEVEL_01_META:Class;
		[Embed(source = "../assets/levels/meta/level02.xml", mimeType = "application/octet-stream")] public static const LEVEL_02_META:Class;
		[Embed(source = "../assets/levels/meta/level03.xml", mimeType = "application/octet-stream")] public static const LEVEL_03_META:Class;
		[Embed(source = "../assets/levels/meta/level04.xml", mimeType = "application/octet-stream")] public static const LEVEL_04_META:Class;
		[Embed(source = "../assets/levels/meta/level05.xml", mimeType = "application/octet-stream")] public static const LEVEL_05_META:Class;
		[Embed(source = "../assets/levels/meta/level06.xml", mimeType = "application/octet-stream")] public static const LEVEL_06_META:Class;
		[Embed(source = "../assets/levels/meta/level07.xml", mimeType = "application/octet-stream")] public static const LEVEL_07_META:Class;
		[Embed(source = "../assets/levels/meta/level08.xml", mimeType = "application/octet-stream")] public static const LEVEL_08_META:Class;
		[Embed(source = "../assets/levels/meta/level09.xml", mimeType = "application/octet-stream")] public static const LEVEL_09_META:Class;
		[Embed(source = "../assets/levels/meta/level10.xml", mimeType = "application/octet-stream")] public static const LEVEL_10_META:Class;
		[Embed(source = "../assets/levels/meta/level11.xml", mimeType = "application/octet-stream")] public static const LEVEL_11_META:Class;
		[Embed(source = "../assets/levels/meta/level12.xml", mimeType = "application/octet-stream")] public static const LEVEL_12_META:Class;
		[Embed(source = "../assets/levels/meta/level13.xml", mimeType = "application/octet-stream")] public static const LEVEL_13_META:Class;
		[Embed(source = "../assets/levels/meta/level14.xml", mimeType = "application/octet-stream")] public static const LEVEL_14_META:Class;
		[Embed(source = "../assets/levels/meta/level15.xml", mimeType = "application/octet-stream")] public static const LEVEL_15_META:Class;
		[Embed(source = "../assets/levels/meta/level16.xml", mimeType = "application/octet-stream")] public static const LEVEL_16_META:Class;
		[Embed(source = "../assets/levels/meta/level17.xml", mimeType = "application/octet-stream")] public static const LEVEL_17_META:Class;
		[Embed(source = "../assets/levels/meta/level18.xml", mimeType = "application/octet-stream")] public static const LEVEL_18_META:Class;
		[Embed(source = "../assets/levels/meta/level19.xml", mimeType = "application/octet-stream")] public static const LEVEL_19_META:Class;
		[Embed(source = "../assets/levels/meta/level20.xml", mimeType = "application/octet-stream")] public static const LEVEL_20_META:Class;

	}

}