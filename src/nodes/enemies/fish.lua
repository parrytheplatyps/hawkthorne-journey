local tween = require 'vendor/tween'

return {
    name = 'fish',
    die_sound = 'acorn_squeak',
    height = 37,
    width = 28,
    position_offset = { x = 10, y = 50 },
    bb_width = 20,
    bb_height = 32,
    bb_offset = {x=0, y=0},
    damage = 1,
    hp = 1,
    jumpkill = false,
    antigravity = true,
    easeup = 'outQuad',
    easedown = 'inQuad',
    movetime = 1,
    bounceheight = 140,
    dyingdelay = 3, 
    animations = {
        dying = {
            right = {'once', {'3,1'}, 1},
            left = {'once', {'3,1'}, 1}
        },
        default = {
            right = {'loop', {'1-2,1'}, 0.3},
            left = {'loop', {'1-2,1'}, 0.3}
        }
    },
    enter = function(enemy)
        enemy.delay = math.random(10)/2
        enemy.startmove = function()
            enemy.moving = true
            tween.start( enemy.props.movetime, enemy.position, { y = enemy.node.y - enemy.props.bounceheight }, enemy.props.easeup, enemy.reversemove )
        end
        enemy.reversemove = function()
            tween.start( enemy.props.movetime, enemy.position, { y = enemy.node.y + enemy.position_offset.y }, enemy.props.easedown, function() enemy.moving = false end )
        end
    end,
    update = function(dt, enemy, player)
        if enemy.delay >= 0 then
            enemy.delay = enemy.delay - dt
        else
            if not enemy.moving then
                enemy.startmove()
            end
        end
    end
}