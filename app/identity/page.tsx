import ProfileCard from "./components/ProfileCard";
import GoalsList from "./components/GoalsList";
import ArchetypeCards from "./components/ArchetypeCards";
import DimensionsBars from "./components/DimensionsBars";

export default function IdentityPage() {
  return (
    <div className="p-6 space-y-12">
      <ProfileCard />

      <section>
        <h2 className="text-2xl font-semibold mb-4">Ziele</h2>
        <GoalsList />
      </section>

      <section>
        <h2 className="text-2xl font-semibold mb-4">Archetypen</h2>
        <ArchetypeCards />
      </section>

      <section>
        <h2 className="text-2xl font-semibold mb-4">Dimensionen</h2>
        <DimensionsBars />
      </section>
    </div>
  );
}
