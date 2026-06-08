import Image from "next/image";
import Link from "next/link";

export default function HomePage() {
  return (
    <main className="min-h-screen bg-[#f7f7ff] text-black">
      {/* Navbar */}
      <nav className="h-[72px] bg-white flex items-center justify-between px-10 shadow-sm">
        <h1 className="text-[22px] font-bold tracking-tight">ShapeRush</h1>

        <div className="hidden md:flex items-center gap-9 text-[13px] font-medium">
          <a href="#home">Home</a>
          <a href="#features">Features</a>
          <a href="#plans">Plans</a>
          <a href="#reviews">Reviews</a>
          <a href="#faq">FAQ</a>
        </div>

        <Link
          href="/register"
          className="bg-[#6c5cff] text-white px-8 py-3 rounded-xl text-[13px] font-semibold"
        >
          Register
        </Link>
      </nav>

      {/* Hero */}
      <section
        id="home"
        className="relative bg-[#f8f8ff] min-h-[520px] overflow-hidden flex items-center"
      >
        <div className="w-full px-10 md:px-24 grid grid-cols-1 md:grid-cols-2 items-center gap-10">
          <div>
            <h2 className="text-[48px] md:text-[54px] leading-[1.05] font-bold">
              Train smarter.
              <br />
              <span className="text-[#7c83e9]">See real results.</span>
            </h2>

            <p className="mt-6 text-[14px] leading-6 text-gray-500 max-w-[430px]">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
              dolor sit tincidunt ut labore et dolore magna aliqua. Dolor sit
              amet, consectetur adipiscing elit.
            </p>

            <Link
              href="/register"
              className="inline-block mt-7 bg-[#6c5cff] text-white px-7 py-4 rounded-xl text-[13px] font-semibold shadow-lg shadow-purple-200"
            >
              Get Started Free <span className="ml-4">→</span>
            </Link>

            <div className="mt-10 flex items-center gap-5">
              <div className="relative w-[130px] h-[52px]">
                <Image
                  src="/images/avatar-group.png"
                  alt="Active users"
                  fill
                  className="object-contain"
                />
              </div>

              <div>
                <p className="text-[18px] font-bold">50K+</p>
                <p className="text-[14px] text-gray-500">
                  Monthly Active User
                </p>
              </div>
            </div>
          </div>

          <div className="relative hidden md:block h-[500px]">
            <Image
              src="/images/hero-phones.png"
              alt="ShapeRush app preview"
              fill
              priority
              className="object-contain object-bottom"
            />
          </div>
        </div>
      </section>

      {/* Features */}
      <section
        id="features"
        className="bg-[#f0f1ff] px-10 md:px-24 py-24 grid grid-cols-1 md:grid-cols-2 gap-24 items-center"
      >
        <div className="max-w-[650px]">
          <Image
            src="/images/feature-workout.png"
            alt="Users checking workout progress"
            width={1040}
            height={780}
            className="w-full h-auto rounded-[22px]"
          />
        </div>

        <div>
          <p className="text-[#6c5cff] text-[13px] font-semibold uppercase">
            Features
          </p>

          <h2 className="text-[24px] font-bold mt-2">
            Everything to crush your goals
          </h2>

          <div className="grid grid-cols-1 sm:grid-cols-3 gap-x-12 gap-y-12 mt-10">
            <Feature
              icon="/images/icon-personalized.png"
              title="Personalised Plans"
            />

            <Feature
              icon="/images/icon-workout.png"
              title="Workout Tracking"
            />

            <Feature
              icon="/images/icon-progress.png"
              title="Progress Analytics"
            />

            <Feature
              icon="/images/icon-nutrition.png"
              title="Nutrition Support"
            />

            <Feature
              icon="/images/icon-rewards.png"
              title="Streaks & Rewards"
            />

            <Feature
              icon="/images/icon-community.png"
              title="Community Support"
            />
          </div>
        </div>
      </section>

      {/* Plans */}
      <section
        id="plans"
        className="relative overflow-hidden bg-[#fafaff] px-10 md:px-24 py-24"
      >
        <h1 className="absolute bottom-[-38px] left-0 right-0 text-[150px] md:text-[180px] font-bold text-[#ececf7] z-0 text-center leading-none">
          ShapeRush
        </h1>

        <div className="relative z-10 text-center">
          <p className="text-[#6c5cff] text-[13px] font-semibold uppercase">
            Subscription Plans
          </p>

          <h2 className="text-[24px] font-bold mt-2">
            Unlock Your Best Self
          </h2>

          <div className="mt-12 flex flex-col md:flex-row justify-center gap-8">
            <PlanCard title="Free" price="$0" />
            <PlanCard title="Premium" price="$7.99" premium />
          </div>
        </div>
      </section>

      {/* Testimonials */}
      <section id="reviews" className="bg-white px-0 py-20 overflow-hidden">
        <div className="grid grid-cols-1 md:grid-cols-3 items-center gap-10">
          <div className="hidden md:flex gap-3 -ml-8">
            <PersonCard image="/images/testimonial-1.png" />
            <PersonCard image="/images/testimonial-2.png" />
            <PersonCard image="/images/testimonial-3.png" />
          </div>

          <div className="text-center px-10">
            <p className="text-[#6c5cff] text-[13px] font-semibold uppercase">
              Testimonials
            </p>

            <h2 className="text-[24px] font-bold mt-2">What Users Say</h2>

            <p className="mt-8 text-[16px] leading-7">
              “This app is like having a personal trainer with you 24/7. The
              guided workouts are clear and easy to follow, and the progress
              tracking keeps me accountable. I&apos;ve never felt more in
              control of my fitness journey. Highly recommend!”
            </p>

            <p className="mt-6 text-gray-400">Luke H.</p>

            <p className="text-yellow-400 text-[22px] mt-2">★ ★ ★ ★ ★</p>

            <div className="flex justify-center gap-3 mt-8">
              <span className="w-5 h-2 bg-[#6c5cff] rounded-full" />
              <span className="w-2 h-2 bg-gray-300 rounded-full" />
              <span className="w-2 h-2 bg-gray-300 rounded-full" />
              <span className="w-2 h-2 bg-gray-300 rounded-full" />
              <span className="w-2 h-2 bg-gray-300 rounded-full" />
            </div>
          </div>

          <div className="hidden md:flex gap-3 -mr-8">
            <PersonCard image="/images/testimonial-4.png" />
            <PersonCard image="/images/testimonial-5.png" />
            <PersonCard image="/images/testimonial-6.png" />
          </div>
        </div>
      </section>

      {/* FAQ */}
      <section id="faq" className="bg-[#f8f8ff] px-10 md:px-64 py-24">
        <h2 className="text-[28px] font-bold mb-8">FAQs</h2>

        <FAQItem question="Is ShapeRush free to use?" />
        <FAQItem question="Can I track weight, workout, or intermittent fasting?" />
        <FAQItem question="What do I need to get started?" />
      </section>

      {/* Footer */}
      <footer className="bg-white px-10 md:px-12 py-16 grid grid-cols-1 md:grid-cols-4 gap-12">
        <div>
          <h2 className="text-[34px] font-bold">ShapeRush</h2>

          <p className="mt-5 text-[14px] leading-6 text-gray-500">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
            dolor sit tincidunt ut labore et dolore magna aliqua. Dolor sit
            amet, consectetur adipiscing elit.
          </p>

          <p className="mt-5 text-gray-500">©2026 by ShapeRush</p>
        </div>

        <FooterColumn
          title="Address"
          lines={["641 Clementi Road,", "Singapore 556431"]}
        />

        <div>
          <p className="text-[#6c5cff] text-[14px] mb-5">Legal</p>

          <div className="space-y-3 text-[15px]">
            <Link href="/privacy-policy" className="block">
              Privacy Policy
            </Link>

            <Link href="/terms-and-conditions" className="block">
              Terms and Conditions
            </Link>
          </div>
        </div>

        <FooterColumn title="Contact Us" lines={["shaperush@gmail.com"]} />
      </footer>
    </main>
  );
}

function Feature({ icon, title }) {
  return (
    <div>
      <div className="relative w-8 h-8">
        <Image src={icon} alt={title} fill className="object-contain" />
      </div>

      <h3 className="mt-4 text-[14px] font-bold">{title}</h3>

      <p className="mt-2 text-[12px] leading-4 text-gray-500">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.
      </p>
    </div>
  );
}

function PlanCard({ title, price, premium }) {
  return (
    <div
      className={`w-[310px] min-h-[390px] bg-white rounded-[22px] p-8 text-left ${
        premium ? "border-2 border-[#6c5cff]" : ""
      }`}
    >
      <h3 className="text-[22px] font-bold">{title}</h3>

      <p className="mt-3 text-[12px] leading-5 text-gray-500">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.
      </p>

      <div className="mt-10 flex items-end">
        <p className="text-[32px] font-medium">{price}</p>
        {premium && <span className="ml-2 mb-2 text-gray-500">/month</span>}
      </div>

      <div className="h-px bg-gray-200 my-5" />

      <ul className="space-y-4 text-[13px]">
        <PlanItem text="Basic workouts" />
        <PlanItem text="Workout tracking" />
        <PlanItem text="Community Access" />
        <PlanItem text="Workout tracking" />

        {premium && (
          <>
            <PlanItem text="Workout tracking" />
            <PlanItem text="Basic workouts" />
          </>
        )}
      </ul>
    </div>
  );
}

function PlanItem({ text }) {
  return (
    <li className="text-[#6c5cff]">
      ✓ <span className="text-black ml-2">{text}</span>
    </li>
  );
}

function PersonCard({ image }) {
  return (
    <div className="relative w-[160px] h-[245px] rounded-xl overflow-hidden bg-gray-100">
      <Image
        src={image}
        alt="ShapeRush user testimonial"
        fill
        className="object-cover object-top"
      />
    </div>
  );
}

function FAQItem({ question }) {
  return (
    <div className="border-b border-gray-200 py-5 flex items-center justify-between">
      <p className="text-[15px]">{question}</p>
      <span className="text-[#6c5cff] text-2xl">+</span>
    </div>
  );
}

function FooterColumn({ title, lines }) {
  return (
    <div>
      <p className="text-[#6c5cff] text-[14px] mb-5">{title}</p>

      <div className="space-y-3 text-[15px]">
        {lines.map((line) => (
          <p key={line}>{line}</p>
        ))}
      </div>
    </div>
  );
}