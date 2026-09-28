package org.erisia.slimestomach;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import net.minecraft.command.CommandBase;
import net.minecraft.command.CommandException;
import net.minecraft.command.ICommandSender;
import net.minecraft.command.WrongUsageException;
import net.minecraft.entity.player.EntityPlayerMP;
import net.minecraft.server.MinecraftServer;
import net.minecraft.util.math.BlockPos;
import net.minecraft.util.text.TextComponentString;

/** /slimestomach list | release <player> | releaseall */
public class CommandSlimeStomach extends CommandBase {
    @Override
    public String getName() {
        return "slimestomach";
    }

    @Override
    public String getUsage(ICommandSender sender) {
        return "/slimestomach list | release <player> | releaseall";
    }

    @Override
    public int getRequiredPermissionLevel() {
        return 2;
    }

    @Override
    public void execute(MinecraftServer server, ICommandSender sender, String[] args) throws CommandException {
        if (args.length == 0) throw new WrongUsageException(getUsage(sender));
        StomachData data = StomachData.get(server);
        StomachEvents events = StomachEvents.INSTANCE;
        switch (args[0]) {
            case "list": {
                if (data.stomachs.isEmpty()) sender.sendMessage(new TextComponentString("No occupied stomachs."));
                for (Stomach s : data.stomachs) {
                    List<String> names = new ArrayList<>();
                    for (UUID u : s.occupants) {
                        EntityPlayerMP p = server.getPlayerList().getPlayerByUUID(u);
                        names.add(p != null ? p.getName() : u + " (offline)");
                    }
                    BlockPos o = s.origin;
                    sender.sendMessage(new TextComponentString(String.format(
                            "#%d: slime at %d %d %d (dim %d); stomach at %d %d %d (dim %d)%s, juice %d/%d; %s",
                            s.id, (int) s.slimeX, (int) s.slimeY, (int) s.slimeZ, s.slimeDim,
                            o.getX(), o.getY(), o.getZ(), s.dimension, s.digesting ? " digesting" : "",
                            s.fillLevel, s.layers(), String.join(", ", names))));
                }
                return;
            }
            case "release": {
                if (args.length != 2) throw new WrongUsageException("/slimestomach release <player>");
                EntityPlayerMP player = getPlayer(server, sender, args[1]);
                Stomach s = data.byOccupant(player.getUniqueID());
                if (s == null) throw new CommandException(player.getName() + " is not inside a slime.");
                events.releaseOne(data, s, player.getUniqueID(), true);
                notifyCommandListener(sender, this, "Released " + player.getName() + " from stomach #" + s.id);
                return;
            }
            case "releaseall": {
                int n = data.stomachs.size();
                for (Stomach s : new ArrayList<>(data.stomachs)) events.free(data, s, "by divine intervention");
                notifyCommandListener(sender, this, "Freed " + n + " stomach(s)");
                return;
            }
            default:
                throw new WrongUsageException(getUsage(sender));
        }
    }

    @Override
    public List<String> getTabCompletions(MinecraftServer server, ICommandSender sender, String[] args, BlockPos targetPos) {
        if (args.length == 1) return getListOfStringsMatchingLastWord(args, "list", "release", "releaseall");
        if (args.length == 2 && args[0].equals("release")) return getListOfStringsMatchingLastWord(args, server.getOnlinePlayerNames());
        return Collections.emptyList();
    }
}
